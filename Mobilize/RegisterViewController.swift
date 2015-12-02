//
//  RegisterViewController.swift
//  Mobilize
//
//  Created by Miguel Araújo on 11/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var userPassword: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func SignUp(sender: AnyObject) {
        
        let nameUser = self.userName.text
        let emailUser = self.userEmail.text
        let password = self.userPassword.text
        
        if ((nameUser?.isEmpty)! || (emailUser?.isEmpty)! || (password?.isEmpty)!) {
            
            var alert = UIAlertController(title: "Alerta!", message: "Todos os campos devem ser preenchidos", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(okAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }else {
            
            let newUser : PFUser = PFUser()
            newUser.username = nameUser
            newUser.email = emailUser
            newUser.password = password
            
            var profileImage : UIImage = UIImage(named: "perfil")!
            let image = UIImageJPEGRepresentation(profileImage, 1)
            
            let userImage : PFFile = PFFile(data: image!)!
            
            newUser.setObject(userImage, forKey: "profile_picture")
            newUser.setObject(nameUser!, forKey: "first_name")
            newUser.setObject(nameUser!, forKey: "last_name")
            
            newUser.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                if success {
                    self.performSegueWithIdentifier("signedUp", sender: self)
                }else {
                    var userMessage = error?.localizedDescription
                    var alert = UIAlertController(title: "Alerta!", message: userMessage, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(okAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
            
            
        }
        
        
        
        
    }
    
    
}
