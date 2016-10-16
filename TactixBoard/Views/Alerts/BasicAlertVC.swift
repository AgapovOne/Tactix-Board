//
//  BasicAlertVC.swift
//  TactixBoard
//
//  Created by Alex Agapov on 16/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit
import SnapKit

protocol BasicAlertVCDelegate: class {
    func didClickSubmitButton(text: String)
}

class BasicAlertVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var titleButtonConstraint: NSLayoutConstraint! // default == 24
    
    weak var delegate: BasicAlertVCDelegate?
    var textField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) { 
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textField?.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalTo(submitButton).offset(24)
            make.top.equalTo(titleLabel).offset(24)
        }
    }
    
    @IBAction func clickSubmit(_ sender: UIButton) {
        if let textField = textField {
            self.delegate?.didClickSubmitButton(text: textField.text ?? "")
        }
    }

    // MARK: - Public methods
    func addTextField() {
        textField = UITextField()
        textField?.backgroundColor = Color.Alert.textFieldColor
        
        self.view.addSubview(textField!)
    }
}
