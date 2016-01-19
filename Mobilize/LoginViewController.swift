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
        self.view.backgroundColor = UIColor(red: 70/255.0, green: 97/255.0, blue: 157/255.0, alpha: 1.0)
        backgroundImage.image = UIImage(named: "wave")
    }
}