//
//  RegisterViewController.swift
//  Mobilize
//
//  Created by Miguel Araújo on 11/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var user_username: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var userPassword: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tapGesture)
        self.userPassword.delegate = self
        self.userPassword.secureTextEntry = true
        self.userPassword.returnKeyType = UIReturnKeyType.Send
    }
    
    
    func keyboardWillShow (notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    
    func keyboardWillHide (notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //This change the navigation bar color
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 70/255.0, green: 97/255.0, blue: 157/255.0, alpha: 0.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 70/255.0, green: 97/255.0, blue: 157/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.translucent = false
        //self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 0.9)
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 70/255.0, green: 97/255.0, blue: 157/255.0, alpha: 1.0)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.userPassword.resignFirstResponder()
        self.SignUp(self)
        return true
    }
    
    @IBAction func SignUp(sender: AnyObject) {
        print("Enviando dados para base de dados!")
        let user_username = self.user_username.text
        let nameUser = self.userName.text
        let emailUser = self.userEmail.text
        let password = self.userPassword.text
        
        if ((nameUser?.isEmpty)! || (user_username?.isEmpty)! || (emailUser?.isEmpty)! || (password?.isEmpty)!) {
            
            var alert = UIAlertController(title: "Alerta!", message: "Todos os campos devem ser preenchidos", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(okAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }else {
            
            let newUser : PFUser = PFUser()
            newUser.username = user_username
            newUser.email = emailUser
            newUser.password = password
            
            var profileImage : UIImage = UIImage(named: "perfil")!
            let image = UIImageJPEGRepresentation(profileImage, 1)
            
            let userImage : PFFile = PFFile(data: image!)!
            
            newUser.setObject(userImage, forKey: "profile_picture")
            newUser.setObject(nameUser!, forKey: "first_name")
            newUser.setObject(nameUser!, forKey: "last_name")
            newUser.setObject(nameUser!, forKey: "name")
            
            newUser.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                if success {
                    //Go back to login page, the user must agree in the confirmation link sent to his email
                    var alert = UIAlertController(title: "Alerta!", message: "Enviamos um email para você, confirme antes de prosseguir!", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(okAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    self.navigationController?.popViewControllerAnimated(true)
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
    
    func dismissKeyboard() {
        
        self.view.endEditing(true)
        
    }
    
    
}
