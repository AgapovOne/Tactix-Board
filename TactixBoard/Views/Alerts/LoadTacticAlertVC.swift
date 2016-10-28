//
//  LoadTacticAlertVC.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 26/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

protocol LoadTacticAlertDelegate: class {
    func didClick(with tactic: Tactic)
}

class LoadTacticAlertVC: UIViewController {
    @IBOutlet private var tableView: UITableView!

    weak var delegate: LoadTacticAlertDelegate?
    var tactics: [Tactic] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TacticAlertCell", bundle: nil), forCellReuseIdentifier: String(describing: TacticAlertCell.self))
        tableView.tableFooterView = UIView()
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension LoadTacticAlertVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tactics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TacticAlertCell.self)) as! TacticAlertCell
        cell.titleLabel?.text = tactics[indexPath.row].name
        return cell
    }
}

extension LoadTacticAlertVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.didClick(with: tactics[indexPath.row])
    }
}
