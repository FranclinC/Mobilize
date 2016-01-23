//
//  Login.swift
//  Mobilize
//
//  Created by Franclin Cabral on 20/10/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4
import Parse

class LoginViewController: UIViewController {
  @IBOutlet var logoMobi: UIImageView!
  @IBOutlet var backgroundImage: UIImageView!
  @IBOutlet var emailUser: UITextField!
  @IBOutlet var passwordUser: UITextField!
  @IBOutlet var logarButton: UIButton!
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var registerUser: UIButton!
  
  var permissionsArray = [Constants.EMAIL, Constants.PUBLIC_PROFILE, Constants.USER_ABOUT_ME]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tapGesture)
    
    self.emailUser.delegate = self
    self.passwordUser.delegate = self
    self.passwordUser.returnKeyType = UIReturnKeyType.Go
    self.passwordUser.secureTextEntry = true
    self.view.backgroundColor = UIColor(red: 70/255.0, green: 97/255.0, blue: 157/255.0, alpha: 1.0)
    backgroundImage.image = UIImage(named: "wave")
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
    if ((PFUser.currentUser()) != nil) {
      let vc : UIViewController = storyboard!.instantiateViewControllerWithIdentifier("mainPage")
      self.navigationController?.pushViewController(vc, animated: false)
    }
    
    if (FBSDKAccessToken.currentAccessToken() != nil){
      let vc : UIViewController = storyboard!.instantiateViewControllerWithIdentifier("mainPage")
      self.navigationController?.pushViewController(vc, animated: false)
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  func logar(){
    let username = self.emailUser.text
    let password = self.passwordUser.text
    
    if (username!.utf16.count < 4 || password!.utf16.count < 5) {
      let alert = UIAlertView(title: "Inválido", message: "Usúario deve ter mais que 4 caracteres e Senha mais que 5 caracteres.", delegate: self, cancelButtonTitle: "OK")
      alert.show()
    }else {
      let query : PFQuery = PFUser.query()!
      query.whereKey(Constants.EMAIL, equalTo: username!)
      
      query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, erro: NSError?) -> Void in
        if objects?.count > 0 {
          let object = objects![0]
          let userNameEmail = object[Constants.USERNAME]
          
          PFUser.logInWithUsernameInBackground(userNameEmail as! String, password: password!, block: { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
              print("USer details: \(user)")
              if (user![Constants.EMAIL_VERIFIED] as! Bool) == true {
                dispatch_async(dispatch_get_main_queue()){
                  NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                  NSUserDefaults.standardUserDefaults().synchronize()
                  self.performSegueWithIdentifier("mainPage", sender: self)
                }
              }else {
                let alertController = UIAlertController(title: "Email address verification", message: "Enviamos um email para você que contém um link para verificação, por favor confirme o registro antes de continuar", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { alertController in self.loginButtonDidLogOut()})
                )
                
                self.presentViewController(alertController, animated: true, completion: nil)
              }
            }
          })
        }else {
          PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
              print("USer details: \(user)")
              if (user![Constants.EMAIL_VERIFIED] as! Bool) == true {
                dispatch_async(dispatch_get_main_queue()){
                  self.performSegueWithIdentifier("mainPage", sender: self)
                }
              }else {
                let alertController = UIAlertController(title: "Email address verification", message: "Enviamos um email para você que contém um link para verificação, por favor confirme o registro antes de continuar", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { alertController in self.loginButtonDidLogOut()})
                )
                
                self.presentViewController(alertController, animated: true, completion: nil)
                self.passwordUser.text = ""
                self.emailUser.text = ""
              }
            }
          })
        }
      })
    }
  }
  
  @IBAction func signInButtonTapped(sender: AnyObject) {
    PFFacebookUtils.logInInBackgroundWithReadPermissions(permissionsArray) { (user: PFUser?, error: NSError?) -> Void in
      
      if let user = user {
        if user.isNew {
          print("User signed up and logged in through Facebook!")
        } else {
          print("User logged in through Facebook!")
        }
      } else {
        print("Uh oh. The user cancelled the Facebook login.")
        self.performSegueWithIdentifier("login", sender: nil)
      }
      
      
      if error != nil {
        let alertError = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alertError.addAction(okAction)
        self.presentViewController(alertError, animated: true, completion: nil)
      }
      
      print(user)
      print("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
      print("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
      
      if FBSDKAccessToken.currentAccessToken() != nil {
        print("Getting data from user's facebook")
        self.returnUserData()
        self.performSegueWithIdentifier("mainPage", sender: nil)
      }
    }
  }
  
  func loginButtonDidLogOut() {
    print("User Logged Out")
    PFUser.logOut()
  }
  
  func returnUserData(){
    let requestParameters = ["fields": "id, email, first_name, last_name"]
    let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
    userDetails.startWithCompletionHandler { (connection, result, error:NSError!) -> Void in
      if(error != nil) {
        print("\(error.localizedDescription)")
        return
      }
      
      if(result != nil) {
        let userId:String = result[Constants.USER_ID] as! String
        let userFirstName:String? = result[Constants.FIRST_NAME] as? String
        let userLastName:String? = result[Constants.LAST_NAME] as? String
        let userEmail:String? = result[Constants.EMAIL] as? String
        print("\(userEmail)")
        
        let myUser:PFUser = PFUser.currentUser()!
        
        if(userFirstName != nil) {
          myUser.setObject(userFirstName!, forKey: Constants.FIRST_NAME)
        }
        
        if(userLastName != nil) {
          myUser.setObject(userLastName!, forKey: Constants.LAST_NAME)
        }
        
        let completeName = userFirstName! + " " + userLastName!
        myUser.setObject(completeName, forKey: Constants.NAME)
        
        if(userEmail != nil) {
          myUser.setObject(userEmail!, forKey: Constants.EMAIL)
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
          let userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
          let profilePictureUrl = NSURL(string: userProfile)
          let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
          
          if(profilePictureData != nil) {
            let profileFileObject = PFFile(data:profilePictureData!)
            myUser.setObject(profileFileObject!, forKey: Constants.PROFILE_PICTURE)
          }
          
          myUser.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
            if(success) {
              print("User details are now updated")
            }
          })
        }
      }
    }
  }
  
  @IBAction func register(sender: AnyObject) {
    self.performSegueWithIdentifier("signUp", sender: self)
  }
  
  func dismissKeyboard() {
    self.view.endEditing(true)
  }
}

// MARK: - UIScrollViewDelegate
extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    self.passwordUser.resignFirstResponder()
    self.logar()
    return true
  }
}