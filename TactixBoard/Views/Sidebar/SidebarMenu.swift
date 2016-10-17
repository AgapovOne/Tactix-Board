//
//  SidebarMenu.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 17/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

@IBDesignable
class SidebarMenu: UIView {
    private enum Menu {
        case add,
        delete,
        draw,
        clear,
        save,
        record,
        play

        var image: UIImage {
            switch self {
            case .add:
                return #imageLiteral(resourceName: "Add")
            case .delete:
                return #imageLiteral(resourceName: "Delete")
            case .draw:
                return #imageLiteral(resourceName: "Draw")
            case .clear:
                return #imageLiteral(resourceName: "Clear")
            case .save:
                return #imageLiteral(resourceName: "Save")
            case .record:
                return #imageLiteral(resourceName: "Rec")
            case .play:
                return #imageLiteral(resourceName: "Play")
            }
        }
    }

    private var menuState: [Menu] = [.add,.delete,.draw,.clear,.save,.record,.play]

    override func layoutSubviews() {
        var previousButton: UIButton?
        for menu in menuState {
            let button = UIButton()
            button.setImage(menu.image, for: .normal)
            button.snp.makeConstraints({ (make) in
                make.leading.trailing.equalToSuperview()
                make.centerX.equalToSuperview()
                if previousButton != nil {
                    make.top.equalTo(previousButton!).offset(8)
                } else {
                    make.top.equalToSuperview()
                }

            })
            self.addSubview(button)
            previousButton = button
        }
    }


}
