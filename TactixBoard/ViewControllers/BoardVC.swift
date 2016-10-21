//
//  BoardVC.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 07/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import UIKit
import SnapKit

class BoardVC: UIViewController {

    @IBOutlet private var boardView: UIImageView!
    @IBOutlet fileprivate var drawView: LineView!

    @IBOutlet private var menuBar: UIView!
    @IBOutlet fileprivate var sidebarMenu: SidebarMenu!

    fileprivate var isDrawing = false
    fileprivate var isRecording = false {
        didSet {
//            if isRecording = true {
//                popAddMenuButton.isHidden = true
//                popDeleteMenuButton.isHidden = true
//            }
        }
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
        drawView.isUserInteractionEnabled = enabled

        for view in self.view.subviews {
            if view is MovableView {
                let movableView = view as! MovableView
                movableView.toggleMoves(enabled: !enabled)
            }
        }
        self.isDrawing = enabled
    }

    fileprivate func clearDrawing() {
        drawView.clear()
    }

    // MARK: Save
    fileprivate func saveImage() {

    }

    // MARK: Recording
    fileprivate func toggleRecording(enabled: Bool) {
        isRecording = enabled
        if isRecording == true {
            let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
            var positions: [MovableView: CGPoint] = [:]
            for el in movableViews {
                positions[el] = el.center
            }
            let state = MovableState(frame: 0, positions: positions)
            tactic = MovableTactic(states: [state], movableViews: movableViews)
        } else {
            // remember tactic
            let alert = BasicAlertVC()
            alert.addTextField()
            alert.delegate = self
            present(alert, animated: true, completion: {
                print("alert")
            })
            /*
             let realm = try! RealmManager.shared.defaultRealm

             let state = State()

             try! realm.write {
             realm.add(Tactic())
             }*/
        }
    }

    fileprivate func saveState(_ sender: UIButton) {
        if isRecording {
            let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
            var positions: [MovableView: CGPoint] = [:]
            for el in movableViews {
                positions[el] = el.center
            }
            let frame = tactic?.states.last?.frame ?? 0
            let state = MovableState(frame: frame + 1, positions: positions)
            tactic?.states.append(state)
        }
    }

    fileprivate func saveFrame() {
        // Save image
        /*let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
         var positions: [MovableView: CGPoint] = [:]
         for el in movableViews {
         positions[el] = el.center
         }
         let state = MovableTactic.State(frame: 0, positions: positions)
         tactic = MovableTactic(states: [state], movableViews: movableViews)*/
    }
    

    // MARK: Play
    fileprivate func playTactic() {
        setupBoard()
        animatePlayers()
    }
}

// MARK: - Alert delegate
extension BoardVC: BasicAlertVCDelegate {
    func didClickSubmitButton(text: String) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Sidebar delegate
extension BoardVC: SidebarDelegate {
    func didClick(button: SidebarButton, type: SidebarButtonEnum) {
        switch type {
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

        case .base(var value):
            button.setAttributedTitle("\(value + 1)".withFont(UIFont.systemFont(ofSize: 18)).withTextColor(Color.cream), for: .normal)
            value += 1

        case .play:
            playTactic()

        case .back:
            if isDrawing == true {
                toggleDrawing(enabled: false)
            }
            if isRecording == true {
                toggleRecording(enabled: false)
            }

//        case .save:
//            saveImage()

        default:
            print("Click unknown button")
        }
    }
}
