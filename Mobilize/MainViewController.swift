//
//  ViewController.swift
//  Mobilize
//
//  Created by Miguel Araújo on 10/19/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
  @IBOutlet var tabBarCustom: UITabBar!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.navigationItem.hidesBackButton = true
    self.navigationController?.navigationBar.translucent = false
    self.tabBarCustom.tintColor = UIColor(red: 70/255.0, green: 97/255.0, blue: 157/255.0, alpha: 1.0)
  }
}
