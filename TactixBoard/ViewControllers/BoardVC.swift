//
//  BoardVC.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 07/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import UIKit
import SnapKit
import PopupDialog

class BoardVC: UIViewController {

    @IBOutlet fileprivate var boardView: UIImageView!
    @IBOutlet fileprivate var drawView: LineView!

    @IBOutlet fileprivate var menuBar: UIView!
    @IBOutlet fileprivate var sidebarMenu: SidebarMenu!

    fileprivate var isDrawing = false
    fileprivate var isRecording = false
    fileprivate var isPlaying = false
    var currentFrame = 0

    fileprivate enum Direction {
        case previous, next
    }

    var tactic: MovableTactic?

    override func viewDidLoad() {
        super.viewDidLoad()

        DrawManager.shared.lineType = .thin

        menuBar.layer.zPosition = 20

        resetBoard()

        sidebarMenu.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBoard()
    }

    // MARK: - Players part
    fileprivate func setupBoard() {
//        PercentPointManager.shared.boardSize = self.boardView.bounds.size

        tactic?.movableViews.forEach {
            boardView.superview?.addSubview($0)
        }

        MovableManager.shared.movableZone = CGRect(x: boardView.frame.minX + 30,
                                                   y: boardView.frame.minY + 30,
                                                   width: boardView.frame.width - 60,
                                                   height: boardView.frame.height - 60)
    }

    fileprivate func resetBoard() {
        let bounds = UIScreen.main.bounds
        let center = CGPoint(x: bounds.midX + 30, y: bounds.midY)
        tactic = MovableTactic.defaultTactic(for: center)
        cleanView()
        setupBoard()
    }

    fileprivate func cleanView() {
        boardView.superview?.subviews.forEach {
            if let view = $0 as? BMovable {
                view.removeFromSuperview()
            }
        }
    }

    fileprivate func animatePlayers(index: Int = 0) {
        if let tactic = tactic {
            if tactic.states.isEmpty == false {
                if self.isPlaying {
                    self.sidebarMenu.setBase(number: index)
                }
                movePlayers(to: index) { finished in
                    if finished {
                        if index < tactic.states.count - 1 {
                            self.animatePlayers(index: index + 1)
                        }
                    }
                }
            }
        }
    }

    fileprivate func movePlayers(to frame: Int, duration: TimeInterval = 0.75, completion: ((Bool) -> ())? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.tactic?.states[frame].positions.forEach({ (el, position) in
                el.center = position
            })
        }, completion: completion)
    }

    // MARK: - Sidebar Menu
    @IBAction func clickLogotype(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: Add players
    fileprivate func addPlayerWithColor(_ color: PlayerView.PlayerColor, num: String = "P") {
        var id = 0
        // Can make number generation here.
        let movableViews = self.view.subviews.filter({ $0 is BMovable }) as! [BMovable]
        movableViews.forEach {
            if $0.id >= id {
                id = $0.id + 1
            }
        }
        let pl = PlayerView(id: id, color: color, num: num, center: self.boardView.center)
        view?.addSubview(pl)
        tactic?.movableViews.append(pl)
    }

    // MARK: Delete players
    fileprivate func removePlayerWithColor(_ color: PlayerView.PlayerColor) {
        let movableViews = self.view.subviews.filter({ ($0 as? PlayerView)?.color == color })
        movableViews.last?.removeFromSuperview()
    }

    fileprivate func removeTeamWithColor(_ color: PlayerView.PlayerColor) {
        let movableViews = self.view.subviews.filter({ ($0 as? PlayerView)?.color == color })
        movableViews.forEach { $0.removeFromSuperview() }
    }

    // MARK: Drawing
    fileprivate func toggleDrawing(enabled: Bool) {
        isDrawing = enabled
        drawView.isUserInteractionEnabled = enabled

        for view in self.view.subviews {
            if view is BMovable {
                let movableView = view as! BMovable
                movableView.toggleMoves(enabled: !enabled)
            }
        }
    }

    fileprivate func clearDrawing() {
        drawView.clear()
    }

    // MARK: Save
    fileprivate func saveImage() {
        // make screenshot
        
        let popup = Alert.PopupWithOK(title: "Хотите сохранить?", message: "Доска будет сохранена в ваших фотографиях") {
            UIGraphicsBeginImageContextWithOptions(self.boardView.bounds.size, false, 0.0)
            let context = UIGraphicsGetCurrentContext()!
            context.translateBy(x: -self.boardView.frame.minX, y: 0)
            self.boardView.superview?.layer.render(in: context)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // save to photos
            if let image = screenshot {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        }

        present(popup, animated: true, completion: nil)
    }

    // MARK: Recording
    fileprivate func toggleRecording(enabled: Bool) {
        isRecording = enabled
    }

    fileprivate func saveState() {
        let movableViews = self.view.subviews.filter({ $0 is BMovable }) as! [BMovable]
        var positions: [BMovable: CGPoint] = [:]
        for el in movableViews {
            positions[el] = el.center
        }
        let state = MovableState(frame: currentFrame, positions: positions)
        if currentFrame == 0 {
            tactic = MovableTactic(states: [state], movableViews: movableViews)
        } else if currentFrame == tactic?.states.count {
            tactic?.states.append(state)
        } else {
            tactic?.states[currentFrame] = state
        }
        currentFrame += 1
    }

    fileprivate func changeRecordingFrame(direction: Direction) {
        if let tactic = tactic {
            switch direction {
            case .previous:
                if currentFrame > 0 {
                    currentFrame -= 1
                    movePlayers(to: currentFrame)
                }
            case .next:
                if currentFrame + 1 < tactic.states.count {
                    currentFrame += 1
                    movePlayers(to: currentFrame)
                } else if currentFrame + 1 == tactic.states.count {
                    currentFrame += 1
                }
            }
        }

        sidebarMenu.setBase(number: currentFrame)
    }

    fileprivate func saveTactic() {
        guard tactic != nil, tactic!.states.isEmpty == false else {
            return
        }
        movePlayers(to: 0, duration: 0.25) { finished in
            self.currentFrame = 0
            self.sidebarMenu.setBase(number: 0)

            let popup = Alert.PopupWithTextField(title: "Введите название:") { [weak self] name in
                do {
                    if let unwrappedTactic = self?.tactic {
                        let realm = RealmManager.shared.defaultRealm

                        let tactic = RealmTactic(name: name, tactic: unwrappedTactic)

                        try realm.write {
                            realm.add(tactic)
                            print("Saved")

                            //self.tactic?.states = []
                            self?.resetBoard()
                        }
                    }
                } catch(let err) {
                    self?.present(PopupDialog(title: "Ошибка", message: err.localizedDescription), animated: true, completion: nil)
                }
            }

            self.present(popup, animated: true) {
                popup.viewController.becomeFirstResponder()
            }
        }
    }

    // MARK: Play
    fileprivate func togglePlaying(enabled: Bool) {
        isPlaying = enabled
        showTactics()
    }

    fileprivate func showTactics() {
        if isPlaying {
            let realm = RealmManager.shared.defaultRealm

            let tactics = Array(realm.objects(RealmTactic.self))
            let (table, popup) = Alert.PopupWithTactics(title: "", tactics: tactics)
            table.delegate = self
            present(popup, animated: true) {

            }
        }
    }

    fileprivate func playTactic() {
        setupBoard()
        animatePlayers()
        currentFrame = (tactic?.states.count ?? 1) - 1
    }

    fileprivate func playFrame(_ direction: Direction) {
        if let tactic = tactic {
            switch direction {
            case .previous:
                if currentFrame > 0 {
                    currentFrame -= 1
                    movePlayers(to: currentFrame)
                }
            case .next:
                if currentFrame + 1 < tactic.states.count {
                    currentFrame += 1
                    movePlayers(to: currentFrame)
                }
            }
        }
        sidebarMenu.setBase(number: currentFrame)
    }
}

// MARK: - Sidebar delegate
extension BoardVC: SidebarDelegate {
    func didClick(_ button: SidebarButton, type: SidebarButtonEnum) {
        switch type {
        // Add
        case .addRed:
            addPlayerWithColor(.red)
        case .addBlue:
            addPlayerWithColor(.blue)
        case .addBlack:
            addPlayerWithColor(.black)
        case .addOrangeGK:
            addPlayerWithColor(.orange, num: "G")
        case .addGreenGK:
            addPlayerWithColor(.green, num: "G")

        // Delete
        case .deleteRed:
            removePlayerWithColor(.red)
        case .deleteBlue:
            removePlayerWithColor(.blue)
        case .deleteBlack:
            removePlayerWithColor(.black)
        case .deleteBlueTeam:
            removeTeamWithColor(.blue)
        case .deleteOrangeGK:
            removePlayerWithColor(.orange)
        case .deleteGreenGK:
            removePlayerWithColor(.green)

        // Draw
        case .draw:
            toggleDrawing(enabled: true)
        case .clear:
            clearDrawing()
        case .thinLine:
            DrawManager.shared.lineType = .thin
        case .thickLine:
            DrawManager.shared.lineType = .thick
        case .dashedLine:
            DrawManager.shared.lineType = .dashed

        case .save:
            saveImage()

        // Recording
        case .recordMenu:
            toggleRecording(enabled: true)
        case .more:
            showTactics()
        case .stop:
            saveTactic()

        // Play
        case .playMenu:
            togglePlaying(enabled: true)
        case .play:
            playTactic()


        // Basic
        case .base:
            if isRecording {
                print("record")
                saveState()
                button.setAttributedTitle("\(currentFrame)".withFont(UIFont.systemFont(ofSize: 18)).withTextColor(Color.cream), for: .normal)
            }
            if isPlaying {
                print("play")
            }

        case .previous:
            if isRecording {
                changeRecordingFrame(direction: .previous)
            }
            if isPlaying {
                playFrame(.previous)
            }
        case .next:
            if isRecording {
                changeRecordingFrame(direction: .next)
            }
            if isPlaying {
                playFrame(.next)
            }

        case .back:
            if isDrawing {
                toggleDrawing(enabled: false)
            }
            if isRecording {
                toggleRecording(enabled: false)
            }
            if isPlaying {
                togglePlaying(enabled: false)
            }
            currentFrame = 0

        default:
            print("Click unknown button")
        }
    }
}

extension BoardVC: LoadTacticAlertDelegate {
    func didClick(with tactic: RealmTactic) {
        print("Hello it's a click!")
        self.tactic = MovableTactic(tactic)
        dismiss(animated: true) {
            self.cleanView()
            self.setupBoard()
        }
    }
}

extension BoardVC {
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
