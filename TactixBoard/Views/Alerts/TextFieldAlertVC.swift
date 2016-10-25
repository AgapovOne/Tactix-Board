//
//  TextFieldAlertVC.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 24/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class TextFieldAlertVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    var titleLabelText = "Enter:"

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleLabelText
    }

    /*static func instantiate(title: String) -> TextFieldAlertView {
        let textFieldAlertVC = UIStoryboard(name: "Alerts", bundle: Bundle.main).instantiateViewController(withIdentifier: "TextFieldAlertVC") as! TextFieldAlertVC
        textFieldAlertVC.titleLabelText = title
        return textFieldAlertVC
    }*/
}
