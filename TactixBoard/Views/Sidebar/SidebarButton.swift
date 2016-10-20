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
    action
}

enum SidebarButtonEnum {
    case addMenu,
    deleteMenu,
    drawMenu,
    clearMenu,
    saveMenu,
    recordMenu,
    playMenu,

    back,
    base,

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

    next,
    previous,
    stop,

    more,
    settings

    var image: UIImage {
        switch self {
        case .addMenu:
            return #imageLiteral(resourceName: "Add")
        case .deleteMenu:
            return #imageLiteral(resourceName: "Delete")
        case .drawMenu:
            return #imageLiteral(resourceName: "Draw")
        case .clearMenu:
            return #imageLiteral(resourceName: "Clear")
        case .saveMenu:
            return #imageLiteral(resourceName: "Save")
        case .recordMenu:
            return #imageLiteral(resourceName: "Rec")
        case .playMenu:
            return #imageLiteral(resourceName: "Play")

        case .back:
            return #imageLiteral(resourceName: "Back")
        case .base:
            return #imageLiteral(resourceName: "Base Icon")

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

        case .more:
            return #imageLiteral(resourceName: "More")
        case .settings:
            return #imageLiteral(resourceName: "Settings")
        }
    }

    var type: SidebarButtonType? {
        switch self {
        case .add, .delete, .draw, .record, .play, .back:
            return .expand
        default:
            return .action
        }
    }

    var state: [SidebarButtonEnum]? {
        switch self {
        case .add:
            return [.back, .addRed, .addBlue, .addBlack, .addOrangeGK, .addGreenGK]
        case .delete:
            return [.back, .deleteRed, .deleteBlue, .deleteBlack, .deleteBlueTeam, .deleteOrangeGK, .deleteGreenGK]
        case .draw:
            return [.back, .thinLine, .thickLine, .dashedLine]
        case .record:
            return [.back, .base, .previous, .next, .stop]
        case .play:
            return [.back, .play, .previous, .next, .base]
        case .back:
            return SidebarMenu.defaultState
        default:
            return nil
        }
    }
}

class SidebarButton: UIButton {
    var action: (() -> ())?
    var type: SidebarButtonEnum?
}
