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
    var tactic: Tactic?

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

    func setupBoard() {
        tactic?.movableViews.forEach {
            boardView.superview?.addSubview($0)
        }

        MovableManager.shared.movableZone = CGRect(x: boardView.frame.minX + 30,
                                                  y: boardView.frame.minY + 30,
                                                  width: boardView.frame.width - 60,
                                                  height: boardView.frame.height - 60)
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
        self.navigationController?.popViewController(animated: true)
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

    @IBAction func saveState(_ sender: UIButton) {
        let movableViews = self.view.subviews.filter({ $0 is MovableView }) as! [MovableView]
        let state = Tactic.State(positions: movableViews.map({ $0.center }))
        tactic = Tactic(states: [state], movableViews: movableViews)
    }
}
