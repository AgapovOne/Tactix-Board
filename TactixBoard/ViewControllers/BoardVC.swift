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

    @IBOutlet private var menuBar: UIView!
    @IBOutlet fileprivate var sidebarMenu: SidebarMenu!

    fileprivate var isDrawing = false
    fileprivate var isRecording = false
    fileprivate var isPlaying = false
    var currentFrame = 0

    enum Direction {
        case previous, next
    }

    var tactic: MovableTactic?

    override func viewDidLoad() {
        super.viewDidLoad()

        DrawManager.shared.lineType = .thin

        menuBar.layer.zPosition = 20

        let bounds = UIScreen.main.bounds
        let center = CGPoint(x: bounds.midX + 30, y: bounds.midY)
        tactic = MovableManager.shared.defaultTactic(for: center)

        sidebarMenu.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBoard()
    }

    // MARK: - Players part
    private func setupBoard() {
        tactic?.movableViews.forEach {
            boardView.superview?.addSubview($0)
        }

        MovableManager.shared.movableZone = CGRect(x: boardView.frame.minX + 30,
                                                   y: boardView.frame.minY + 30,
                                                   width: boardView.frame.width - 60,
                                                   height: boardView.frame.height - 60)
    }

    fileprivate func animatePlayers(index: Int = 0) {
        if let tactic = tactic {
            if tactic.states.isEmpty == false {
                let duration = index == 0
                    ? 0.2
                    : 1.0
                UIView.animate(withDuration: duration, animations: {
                    tactic.states[index].positions.forEach({ (el, position) in
                        el.center = position
                    })
                }) { finished in
                    if finished {
                        if index < tactic.states.count - 1 {
                            self.animatePlayers(index: index + 1)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Sidebar Menu
    @IBAction func clickLogotype(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: Add players
    fileprivate func addPlayerWithColor(_ color: UIColor, num: String = "P") {
        var id = 0
        // Can make number generation here.
        let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
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
    fileprivate func removePlayerWithColor(_ color:UIColor) {
        let movableViews = self.view.subviews.filter({ $0 is MovableView && $0.backgroundColor == color }) as! [MovableView]
        if movableViews.isEmpty == false {
            movableViews[0].removeFromSuperview()
        }
    }

    fileprivate func removeTeamWithColor(_ color:UIColor) {
        let movableViews = self.view.subviews.filter({ $0 is MovableView && $0.backgroundColor == color }) as! [MovableView]
        if movableViews.isEmpty == false {
            movableViews.forEach { $0.removeFromSuperview() }
        }
    }

    // MARK: Drawing
    fileprivate func toggleDrawing(enabled: Bool) {
        isDrawing = enabled
        drawView.isUserInteractionEnabled = enabled

        for view in self.view.subviews {
            if view is MovableView {
                let movableView = view as! MovableView
                movableView.toggleMoves(enabled: !enabled)
            }
        }
    }

    fileprivate func clearDrawing() {
        drawView.clear()
    }

    // MARK: Save
    /**
     Saves image to photos. 
     // TODO: Save to db/documents to use later in trainings :)
     */
    fileprivate func saveImage() {
        // make screenshot 
        // TODO: Screenshot only for board view, without sidebar.
        // 1 option
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0)
        self.view.drawHierarchy(in: view.bounds.offsetBy(dx: -60, dy: 0), afterScreenUpdates: true)
//        self.view.snapshotView(afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // 2 option
//        UIGraphicsBeginImageContextWithOptions(boardView.bounds.size, false, UIScreen.main.scale)
//        boardView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()


        let textFieldAlert = TextFieldAlertVC(nibName: "TextFieldAlertVC", bundle: nil)
        textFieldAlert.titleLabelText = "Введите название:"

        let popup = PopupDialog(viewController: textFieldAlert, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: true)

        let buttonOne = CancelButton(title: "Отменить") {
            print("Cancelled")
        }
        let buttonTwo = DefaultButton(title: "Сохранить") {
            let tacticName: String = textFieldAlert.textField.text ?? ""
            print(tacticName) // use name somehow.

            // save to photos
            UIImageWriteToSavedPhotosAlbum(cropped, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        popup.addButtons([buttonOne, buttonTwo])

        present(popup, animated: true) {
//            textFieldAlert.textField.becomeFirstResponder()
        }
    }

    // MARK: Recording
    fileprivate func toggleRecording(enabled: Bool) {
        isRecording = enabled
    }

    fileprivate func saveState() {
        let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
        var positions: [MovableView: CGPoint] = [:]
        for el in movableViews {
            positions[el] = el.center
        }
        let frame = currentFrame
        let state = MovableState(frame: frame, positions: positions)
        if frame == 0 {
            tactic = MovableTactic(states: [state], movableViews: movableViews)
        } else if frame == tactic?.states.count {
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
                    tactic.states[currentFrame].positions.forEach({ (el, position) in
                        el.center = position
                    })
                }
            case .next:
                if currentFrame + 1 < tactic.states.count {
                    currentFrame += 1
                    tactic.states[currentFrame].positions.forEach({ (el, position) in
                        el.center = position
                    })
                }
            }
        }

        // TODO: CHANGE FRAME NUMBER ON A BUTTON!
    }

    fileprivate func saveTactic() {

        /*let realm = try! RealmManager.shared.defaultRealm

        let state = State()

        try! realm.write {
            realm.add(Tactic())
        }*/
    }


    // MARK: Play
    fileprivate func togglePlaying(enabled: Bool) {
        isPlaying = enabled
        if isPlaying {

        } else {

        }
    }

    fileprivate func playTactic() {
        setupBoard()
        animatePlayers()
    }

    fileprivate func playFrame() {

    }
}

// MARK: - Sidebar delegate
extension BoardVC: SidebarDelegate {
    func didClick(button: SidebarButton, type: SidebarButtonEnum) {
        switch type {
        // Add
        case .addRed:
            addPlayerWithColor(Color.red)
        case .addBlue:
            addPlayerWithColor(Color.blue)
        case .addBlack:
            addPlayerWithColor(Color.black)
        case .addOrangeGK:
            addPlayerWithColor(Color.orange, num: "G")
        case .addGreenGK:
            addPlayerWithColor(Color.green, num: "G")

        // Delete
        case .deleteRed:
            removePlayerWithColor(Color.red)
        case .deleteBlue:
            removePlayerWithColor(Color.blue)
        case .deleteBlack:
            removePlayerWithColor(Color.black)
        case .deleteBlueTeam:
            removeTeamWithColor(Color.blue)
        case .deleteOrangeGK:
            removePlayerWithColor(Color.orange)
        case .deleteGreenGK:
            removePlayerWithColor(Color.green)

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
            }
            if isPlaying {
                print("play")
            }
            button.setAttributedTitle("\(currentFrame)".withFont(UIFont.systemFont(ofSize: 18)).withTextColor(Color.cream), for: .normal)

        case .previous:
            if isRecording {
                changeRecordingFrame(direction: .previous)
            }
            if isPlaying {

            }
        case .next:
            if isRecording {
                changeRecordingFrame(direction: .next)
            }
            if isPlaying {
                
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

extension BoardVC {
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
