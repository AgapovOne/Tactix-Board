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

    @IBOutlet weak var boardView: UIImageView!
    @IBOutlet weak var drawView: LineView!

    @IBOutlet weak var menuBar: UIView!

    @IBOutlet weak var popAddMenu: AddMenu!
    @IBOutlet weak var popDeleteMenu: DeleteMenu!
    @IBOutlet weak var popLineTypeMenu: LineTypeMenu!

    var isDrawing = false
    var isRecording = false {
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

        LineView().setLineType(.thin)

        menuBar.layer.zPosition = 20
        popAddMenu.layer.zPosition = 20
        popDeleteMenu.layer.zPosition = 20
        popLineTypeMenu.layer.zPosition = 20

        let bounds = UIScreen.main.bounds
        let center = CGPoint(x: bounds.midX + 30, y: bounds.midY)
        tactic = MovableManager.shared.defaultTactic(for: center)
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
            let duration = index == 0
                ? 0.2
                : 1.0
            UIView.animate(withDuration: duration, animations: {
                tactic.states[index].positions.forEach({ (id, position) in
                    tactic.movableViews.filter({ $0.id == id })[0].center = position // FIXME: Always filtering movableView is a bad idea.
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

    // MARK: - Sidebar Menu

    func toggle(menu: UIView, sender: UIButton) {
        if menu.isHidden == true {
            menu.isHidden = false
            sender.backgroundColor = Color.sidebarButtonActiveColor
        } else {
            menu.isHidden = true
            sender.backgroundColor = Color.sidebarButtonColor
        }
    }

    @IBAction func clickLogotype(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clearDrawings(_ sender: UIButton) {
        drawView.clear()
        LineView().setLineType(.thick)
    }

    @IBAction func popLineTypeMenuShow(_ sender: UIButton) {
        let menu = popLineTypeMenu
        toggle(menu: menu!,sender: sender)
    }

    @IBAction func startDrawings(_ sender: UIButton) {
        if isDrawing == false {
            drawView.isUserInteractionEnabled = true
            sender.backgroundColor = Color.sidebarButtonActiveColor

            for view in self.view.subviews {
                if view is MovableView {
                    let movableView = view as! MovableView
                    movableView.disableMoves()
                }
            }
            self.isDrawing = true
        } else {
            drawView.isUserInteractionEnabled = false
            sender.backgroundColor = Color.sidebarButtonColor

            for view in self.view.subviews {
                if view is MovableView {
                    let movableView = view as! MovableView
                    movableView.enableMoves()
                }
            }
            self.isDrawing = false
        }
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

    @IBAction func toggleRecording(_ sender: UIButton) {
        isRecording = !isRecording
        if isRecording == true {
            sender.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
            sender.backgroundColor = Color.sidebarButtonActiveColor

            let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
            var positions: [Int: CGPoint] = [:]
            for el in movableViews {
                positions[el.id] = el.center
            }
            let state = TacticStruct.State(positions: positions)
            tactic = TacticStruct(states: [state], movableViews: movableViews)
        } else {
            sender.setImage(#imageLiteral(resourceName: "Rec"), for: .normal)
            sender.backgroundColor = Color.sidebarButtonColor

            // remember tactic
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
            var positions: [Int: CGPoint] = [:]
            for el in movableViews {
                positions[el.id] = el.center
            }
            let state = TacticStruct.State(positions: positions)
            tactic?.states.append(state)
        }
    }

    @IBAction func playTactic(_ sender: UIButton) {
        setupBoard()
        animatePlayers()
    }

}
