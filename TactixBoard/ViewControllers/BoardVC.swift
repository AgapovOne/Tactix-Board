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
    @IBOutlet private var drawView: LineView!

    @IBOutlet private var menuBar: UIView!
    @IBOutlet fileprivate var sidebarMenu: SidebarMenu!

    private var isDrawing = false
    private var isRecording = false {
        didSet {
//            if isRecording = true {
//                popAddMenuButton.isHidden = true
//                popDeleteMenuButton.isHidden = true
//            }
        }
    }
    var tactic: TacticStruct?

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

    func animatePlayers(index: Int = 0) {
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
    func toggle(menu: UIView, sender: UIButton) {
        if menu.isHidden == true {
            menu.isHidden = false
            sender.backgroundColor = Color.Sidebar.buttonActiveColor
        } else {
            menu.isHidden = true
            sender.backgroundColor = Color.Sidebar.buttonColor
        }
    }

    @IBAction func clickLogotype(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clearDrawings(_ sender: UIButton) {
        drawView.clear()
        DrawManager.shared.lineType = .thick
    }

    @IBAction func startDrawings(_ sender: UIButton) {
        if isDrawing == false {
            drawView.isUserInteractionEnabled = true
            sender.backgroundColor = Color.Sidebar.buttonActiveColor

            for view in self.view.subviews {
                if view is MovableView {
                    let movableView = view as! MovableView
                    movableView.disableMoves()
                }
            }
            self.isDrawing = true
        } else {
            drawView.isUserInteractionEnabled = false
            sender.backgroundColor = Color.Sidebar.buttonColor

            for view in self.view.subviews {
                if view is MovableView {
                    let movableView = view as! MovableView
                    movableView.enableMoves()
                }
            }
            self.isDrawing = false
        }
    }
    /*
    @IBAction func popLineTypeMenuShow(_ sender: UIButton) {
        let menu = popLineTypeMenu
        toggle(menu: menu!,sender: sender)
    }

    @IBAction func popAddMenuShow(_ sender: UIButton) {
        let menu = popAddMenu
        toggle(menu: menu!, sender: sender)

        let view = (self.view.subviews.filter({ $0 is MovableView }) as! [MovableView])[0]

        UIView.animate(withDuration: 1.0, animations: {
            view.center = CGPoint(x: 200, y: 200)
        })
    }
    
    @IBAction func popDeleteMenuShow(_ sender: UIButton) {
        let menu = popDeleteMenu
        toggle(menu: menu!, sender: sender)
    }

    */

    @IBAction func toggleRecording(_ sender: UIButton) {
        isRecording = !isRecording
        if isRecording == true {
            sender.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
            sender.backgroundColor = Color.Sidebar.buttonActiveColor

            let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
            var positions: [MovableView: CGPoint] = [:]
            for el in movableViews {
                positions[el] = el.center
            }
            let state = TacticStruct.State(positions: positions)
            tactic = TacticStruct(states: [state], movableViews: movableViews)
        } else {
            sender.setImage(#imageLiteral(resourceName: "Rec"), for: .normal)
            sender.backgroundColor = Color.Sidebar.buttonColor

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

    @IBAction func saveState(_ sender: UIButton) {
        if isRecording {
            let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
            var positions: [MovableView: CGPoint] = [:]
            for el in movableViews {
                positions[el] = el.center
            }
            let state = TacticStruct.State(positions: positions)
            tactic?.states.append(state)
        }
    }

    @IBAction func playTactic(_ sender: UIButton) {
        setupBoard()
        animatePlayers()
    }

    // MARK: Private methods

    fileprivate func addPlayerWithColor(_ color: UIColor, num: String) {
        var id = 0
        let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
        movableViews.forEach { (view) in
            if view.id > id {
                id = view.id
            }
        }
        let pl = PlayerView(id: id + 1, color: color, num: num, center: self.boardView.center)
        view?.addSubview(pl)
        tactic?.movableViews.append(pl)
    }

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

    fileprivate func saveImage() {

    }
}

extension BoardVC: BasicAlertVCDelegate {
    func didClickSubmitButton(text: String) {
        dismiss(animated: true, completion: nil)
    }
}

extension BoardVC: SidebarDelegate {
    func didClick(button: SidebarButton, type: SidebarButtonEnum) {
        switch type {
        case .addRed:
            addPlayerWithColor(Color.red, num: "3")
        case .addBlue:
            addPlayerWithColor(Color.blue, num: "2")
        case .addBlack:
            addPlayerWithColor(Color.black, num: "2")
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

        case .thinLine:
            DrawManager.shared.lineType = .thin
        case .thickLine:
            DrawManager.shared.lineType = .thick
        case .dashedLine:
            DrawManager.shared.lineType = .dashed
        case .save:
            saveImage()

        default:
            print("Click unknown button")
        }
    }
}
