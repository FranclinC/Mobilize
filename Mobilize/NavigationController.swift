//
//  NavigationController.swift
//  Mobilize
//
//  Created by Franclin Cabral on 03/12/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationItem.backBarButtonItem?.title = ""
  }
}

// MARK: - UINavigationControllerDelegate
extension NavigationController: UINavigationControllerDelegate {
}