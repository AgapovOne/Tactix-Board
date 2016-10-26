//
//  TacticAlertCell.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 26/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class TacticAlertCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print("Selected")
    }
}
