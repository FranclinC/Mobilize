//
//  NavigationController.swift
//  Mobilize
//
//  Created by Franclin Cabral on 03/12/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.backBarButtonItem?.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
