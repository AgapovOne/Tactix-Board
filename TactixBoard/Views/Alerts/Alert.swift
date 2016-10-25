//
//  Alert.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 24/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import Foundation
import PopupDialog

class Alert {
    static func setup() {
        // Customize dialog appearance
        let appearance = PopupDialogDefaultView.appearance()
        appearance.backgroundColor = Color.Alert.backgroundColor
        appearance.titleFont = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
        appearance.titleColor = Color.Alert.titleColor
        appearance.messageFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        appearance.messageColor = Color.Alert.titleColor

        // Customize default button appearance
        let db = DefaultButton.appearance()
        db.titleFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        db.titleColor = Color.Alert.textColor
        db.buttonColor = Color.Alert.backgroundColor
        db.separatorColor = Color.Alert.separatorColor

        // Customize cancel button appearance
        CancelButton.appearance().titleFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)

        // Customize overlay appearance
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color = UIColor.black
        overlayAppearance.blurRadius = 20
        overlayAppearance.blurEnabled = true
        overlayAppearance.opacity = 0.7
    }
}

public final class BlackButton: PopupDialogButton {
    override public func setupView() {
        titleFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        defaultTitleColor = Color.Alert.textColor
        defaultButtonColor = Color.Alert.backgroundColor
        defaultSeparatorColor = Color.Alert.separatorColor
        super.setupView()
    }
}
