//
//  SidebarMenu.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 17/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class SidebarMenu: UIView {
    enum Menu {
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

    static let defaultState: [Menu] = [.add, .delete, .draw, .clear, .save, .record, .play]

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildMenu()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildMenu()
    }

    // MARK: Public methods
    func buildMenu(with state: [Menu] = defaultState, animated: Bool = false) {
        if animated {
            for view in subviews {
                UIView.animate(withDuration: 1.0, animations: {
                    view.alpha = 0.0
                }) { (finished) in
                    view.removeFromSuperview()
                }
            }
        }

        for view in subviews {
            view.removeFromSuperview()
        }

        var previousButton: UIButton?
        for menu in state {
            let button = UIButton()
            button.setImage(menu.image, for: .normal)
            self.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.height.width.equalTo(60)
                make.leading.trailing.equalToSuperview()
                make.centerX.equalToSuperview()
                if previousButton != nil {
                    make.top.equalTo(previousButton!.snp.bottom)
                } else {
                    make.top.equalToSuperview()
                }

            })
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
            previousButton = button
        }
    }

    func buttonClick(_ sender: UIButton) {
        print("hello")
        UIView.animate(withDuration: 1.0) {
            self.buildMenu(with: [.add,.delete])
        }
    }
}
