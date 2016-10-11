//
//  BoardVC.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 07/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

class BoardVC: UIViewController {

    @IBOutlet weak var boardView: UIImageView!
    @IBOutlet weak var drawView: LineView!

    @IBOutlet weak var menuBar: UIView!

    @IBOutlet weak var popAddMenu: AddMenu!
    @IBOutlet weak var popDeleteMenu: DeleteMenu!
    @IBOutlet weak var popLineTypeMenu: LineTypeMenu!


    var isDrawing = false

    override func viewDidLoad() {
        super.viewDidLoad()

        LineView().setLineType(.thin)

        menuBar.layer.zPosition = 3
        popAddMenu.layer.zPosition = 3
        popDeleteMenu.layer.zPosition = 3
        popLineTypeMenu.layer.zPosition = 3
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPlayers()

        MovingManager.shared.movableZone = CGRect(x: boardView.frame.minX, y: boardView.frame.minY, width: boardView.frame.width, height: boardView.frame.height)
    }


    // MARK: - Players part

    func loadPlayers() {
        PlayerView.initPlayers(boardView as UIView)
        let boardFrame = boardView.frame
        let ball = BallView(x: boardFrame.width / 2 + menuBar.frame.width, y: boardFrame.height / 2)
        boardView.superview?.addSubview(ball)
    }


    // MARK: - Sidebar Menu

    func showHide(_ menu:UIView,sender:UIButton) {
        if menu.isHidden == true {
            menu.isHidden = false
            sender.backgroundColor = UIColor.flatGreen()
        } else {
            menu.isHidden = true
            sender.backgroundColor = Color.sidebarColor
        }
    }

    @IBAction func clearDrawings(_ sender: UIButton) {
        drawView.clear()
        LineView().setLineType(.thick)
    }

    @IBAction func popLineTypeMenuShow(_ sender: UIButton) {
        let menu = popLineTypeMenu
        showHide(menu!,sender: sender)
    }

    @IBAction func startDrawings(_ sender: UIButton) {
        if isDrawing == false {
            drawView.isUserInteractionEnabled = true
            sender.backgroundColor = UIColor.flatGreen()

            for view in self.view.subviews {
                if view.isKind(of: MovingView.self) {
                    let movingView = view as! MovingView
                    movingView.disableMoves()
                }
            }
            self.isDrawing = true
        } else {
            drawView.isUserInteractionEnabled = false
            sender.backgroundColor = Color.sidebarColor

            for view in self.view.subviews {
                if view.isKind(of: MovingView.self) {
                    let movingView = view as! MovingView
                    movingView.enableMoves()
                }
            }
            self.isDrawing = false
        }
    }
    
    @IBAction func popAddMenuShow(_ sender: UIButton) {
        let menu = popAddMenu
        showHide(menu!, sender: sender)
    }
    
    @IBAction func popDeleteMenuShow(_ sender: UIButton) {
        let menu = popDeleteMenu
        showHide(menu!, sender: sender)
    }
}
