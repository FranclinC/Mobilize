//
//  LoginViewController.swift
//  Mobilize
//
//  Created by Miguel Araújo on 11/10/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = MOBILIZE_BACKGROUND
        backgroundImage.image = UIImage(named: "wave")
    }
}