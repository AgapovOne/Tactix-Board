//
//  SidebarButton.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 20/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

enum SidebarButtonType {
    case expand,
    action,
    expandableAction
}

enum SidebarButtonEnum {
    case addMenu,
    deleteMenu,
    draw,
    clear,
    save,
    recordMenu,
    playMenu,

    back,
    base(Int),
    previous,
    next,

    addRed,
    addBlue,
    addBlack,
    addGreenGK,
    addOrangeGK,

    deleteRed,
    deleteBlue,
    deleteBlack,
    deleteBlueTeam,
    deleteGreenGK,
    deleteOrangeGK,

    thinLine,
    thickLine,
    dashedLine,

    stop,
    play,

    more,
    settings

    var image: UIImage {
        switch self {
        case .addMenu:
            return #imageLiteral(resourceName: "Add")
        case .deleteMenu:
            return #imageLiteral(resourceName: "Delete")
        case .draw:
            return #imageLiteral(resourceName: "Draw")
        case .clear:
            return #imageLiteral(resourceName: "Clear")
        case .save:
            return #imageLiteral(resourceName: "Save")
        case .recordMenu:
            return #imageLiteral(resourceName: "Rec")
        case .playMenu:
            return #imageLiteral(resourceName: "Play")

        case .back:
            return #imageLiteral(resourceName: "Back")
        case .base:
            return #imageLiteral(resourceName: "Base")

        case .addRed:
            return #imageLiteral(resourceName: "AddRed")
        case .addBlue:
            return #imageLiteral(resourceName: "AddBlue")
        case .addBlack:
            return #imageLiteral(resourceName: "AddBlack")
        case .addGreenGK:
            return #imageLiteral(resourceName: "AddDeleteGreenGK")
        case .addOrangeGK:
            return #imageLiteral(resourceName: "AddDeleteOrangeGK")

        case .deleteRed:
            return #imageLiteral(resourceName: "DeleteRed")
        case .deleteBlue:
            return #imageLiteral(resourceName: "DeleteBlue")
        case .deleteBlack:
            return #imageLiteral(resourceName: "DeleteBlack")
        case .deleteBlueTeam:
            return #imageLiteral(resourceName: "DeleteTeam")
        case .deleteGreenGK:
            return #imageLiteral(resourceName: "AddDeleteGreenGK")
        case .deleteOrangeGK:
            return #imageLiteral(resourceName: "AddDeleteOrangeGK")

        case .thinLine:
            return #imageLiteral(resourceName: "ThinLine")
        case .thickLine:
            return #imageLiteral(resourceName: "ThickLine")
        case .dashedLine:
            return #imageLiteral(resourceName: "DashedLine")

        case .next:
            return #imageLiteral(resourceName: "Next")
        case .previous:
            return #imageLiteral(resourceName: "Previous")
        case .stop:
            return #imageLiteral(resourceName: "Stop")

        case .play:
            return #imageLiteral(resourceName: "Play")

        case .more:
            return #imageLiteral(resourceName: "More")
        case .settings:
            return #imageLiteral(resourceName: "Settings")
        }
    }

    var type: SidebarButtonType {
        switch self {
        case .addMenu, .deleteMenu:
            return .expand
        case .draw, .back, .playMenu, .recordMenu:
            return .expandableAction
        default:
            return .action
        }
    }

    var state: [SidebarButtonEnum] {
        switch self {
        case .addMenu:
            return [.back, .addRed, .addBlue, .addBlack, .addOrangeGK, .addGreenGK]
        case .deleteMenu:
            return [.back, .deleteRed, .deleteBlue, .deleteBlack, .deleteBlueTeam, .deleteOrangeGK, .deleteGreenGK]
        case .draw:
            return [.back, .clear, .thinLine, .thickLine, .dashedLine]
        case .recordMenu:
            return [.back, .base(0), .previous, .next, .stop]
        case .playMenu:
            return [.back, .more, .play, .previous, .next, .base(0)]
        default:
            return SidebarMenu.defaultState
        }
    }
}

class SidebarButton: UIButton {
    var action: (() -> ())?
    var type: SidebarButtonEnum?
}
