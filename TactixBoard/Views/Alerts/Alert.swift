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
        appearance.messageColor = Color.Alert.textColor

        // Customize default button appearance
        let db = DefaultButton.appearance()
        db.titleFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        db.titleColor = Color.Alert.textColor
        db.buttonColor = Color.Alert.backgroundColor
        db.separatorColor = Color.Alert.separatorColor

        // Customize cancel button appearance
        let cb = CancelButton.appearance()
        cb.titleFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        cb.titleColor = Color.Alert.textColor
        cb.buttonColor = Color.Alert.backgroundColor
        cb.separatorColor = Color.Alert.separatorColor

        // Customize overlay appearance
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color = UIColor.black
        overlayAppearance.blurEnabled = false
        overlayAppearance.opacity = 0.7
    }
    
    static func PopupWithOK(title: String, message: String? = nil, completion: (() -> ())? = nil) -> PopupDialog {
        let popup = PopupDialog(title: title, message: message, image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: true, completion: nil)
        
        let buttonOne = CancelButton(title: "Отменить") {
            print("Cancelled button clicked")
        }
        
        let buttonTwo = DefaultButton(title: "Ок") {
            completion?()
        }
        popup.addButtons([buttonOne, buttonTwo])
        return popup
    }
    
    static func PopupWithTextField(title: String, completion: @escaping (String) -> ()) -> PopupDialog {
        let textFieldAlert = TextFieldAlertVC(nibName: "TextFieldAlertVC", bundle: nil)
        textFieldAlert.titleLabelText = title

        let popup = PopupDialog(viewController: textFieldAlert, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: true)

        let buttonOne = CancelButton(title: "Отменить") {
            print("Cancelled button clicked")
        }

        let buttonTwo = DefaultButton(title: "Сохранить") {
            completion(textFieldAlert.textField.text ?? "")
        }
        popup.addButtons([buttonOne, buttonTwo])
        return popup
    }

    static func PopupWithTactics(title: String, tactics: [RealmTactic]) -> (LoadTacticAlertVC, PopupDialog) {
        let loadTacticAlert = LoadTacticAlertVC(nibName: String(describing: LoadTacticAlertVC.self), bundle: nil)
        loadTacticAlert.tactics = tactics

        let popup = PopupDialog(viewController: loadTacticAlert, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: false)

        let buttonOne = CancelButton(title: "Отменить") {
            print("Cancelled button clicked")
        }
        popup.addButton(buttonOne)
        return (loadTacticAlert, popup)
    }
}
