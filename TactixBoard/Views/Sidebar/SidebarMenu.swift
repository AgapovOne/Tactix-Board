//
//  SidebarMenu.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 17/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit
import SwiftyAttributes

protocol SidebarDelegate: class {
    func didClick(button: SidebarButton, type: SidebarButtonEnum)
}

class SidebarMenu: UIView {
    weak var delegate: SidebarDelegate?
    static let defaultState: [SidebarButtonEnum] = [.addMenu, .deleteMenu, .draw, .clear, .save, .recordMenu, .playMenu]

    var buttons: [SidebarButton] {
        return subviews.map({ $0 as! SidebarButton })
    }

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
    func buildMenu(with state: [SidebarButtonEnum] = defaultState, animated: Bool = false) {
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

        var previousButton: SidebarButton?
        for buttonEnum in state {
            let button = SidebarButton()
            if case .base(let value) = buttonEnum {
                button.setAttributedTitle("\(value)".withFont(UIFont.systemFont(ofSize: 18)).withTextColor(Color.cream), for: .normal)
                button.setBackgroundImage(buttonEnum.image, for: .normal)
            } else {
                button.setImage(buttonEnum.image, for: .normal)
            }
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
            switch buttonEnum.type {
            case .action:
                button.action = {
                    self.delegate?.didClick(button: button, type: buttonEnum)
                }
            case .expand:
                button.addTarget(self, action: #selector(rebuildMenu(_:)), for: .touchUpInside)
            case .expandableAction:
                button.action = {
                    self.delegate?.didClick(button: button, type: buttonEnum)
                }
                button.addTarget(self, action: #selector(rebuildMenu(_:)), for: .touchUpInside)
            }
            button.type = buttonEnum
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
            previousButton = button
        }
    }

    func buttonClick(_ sender: SidebarButton) {
        sender.action?()
    }

    func rebuildMenu(_ sender: SidebarButton) {
        if let state = sender.type?.state {
            buildMenu(with: state)
        }
    }

    func setBase(number: Int) {
        buttons.filter({
            if let type = $0.type {
                if case .base = type {
                    return true
                }
            }
            return false
        }).forEach {
            $0.setAttributedTitle("\(number)".withFont(UIFont.systemFont(ofSize: 18)).withTextColor(Color.cream), for: .normal)
        }
    }
}
