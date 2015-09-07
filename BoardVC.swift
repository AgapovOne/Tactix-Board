//
//  BoardVC.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 07/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import UIKit

class BoardVC: UIViewController {
  
  @IBOutlet weak var boardView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func addPlayer(sender: UIButton) {
    let newView = PlayerView(frame: CGRectMake(22, 60, 44.0, 44.0))
    boardView.superview?.addSubview(newView)
    //boardView.addSubview(newView)
  }

}
