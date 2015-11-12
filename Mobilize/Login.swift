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

class Login: UIViewController {

    @IBOutlet var loginButton: UIButton!
    
    var permissionsArray = ["user_about_me", "user_relationships", "user_birthday", "user_location"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if (FBSDKAccessToken.currentAccessToken() != nil){
            
            //User is already logged in, perform segue for the next view controller

            let vc : UIViewController = storyboard!.instantiateViewControllerWithIdentifier("mainPage")
            self.navigationController?.pushViewController(vc, animated: false)
            
            //self.performSegueWithIdentifier("mainPage", sender: nil)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    
    
    @IBAction func signInButtonTapped(sender: AnyObject) {
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissionsArray) { (user: PFUser?, error: NSError?) -> Void in
            
            
            if error != nil {
                let alertError = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                alertError.addAction(okAction)
                self.presentViewController(alertError, animated: true, completion: nil)
                
                return
            }
            
            print(user)
            print("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
            
            if FBSDKAccessToken.currentAccessToken() != nil {
                //Save user details in parse
                self.returnUserData()
                
                //Perform segue to navigationController
                self.performSegueWithIdentifier("mainPage", sender: nil)
            }
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    //Just to collect some user data before the segue
    func returnUserData(){
        
        let requestParameters = ["fields": "id, email, first_name, last_name"]
        
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        
        userDetails.startWithCompletionHandler { (connection, result, error:NSError!) -> Void in
            
            if(error != nil)
            {
                print("\(error.localizedDescription)")
                return
            }
            
            if(result != nil)
            {
                
                let userId:String = result["id"] as! String
                let userFirstName:String? = result["first_name"] as? String
                let userLastName:String? = result["last_name"] as? String
                let userEmail:String? = result["email"] as? String
                
                
                print("\(userEmail)")
                
                let myUser:PFUser = PFUser.currentUser()!
                
                // Save first name
                if(userFirstName != nil)
                {
                    myUser.setObject(userFirstName!, forKey: "first_name")
                    
                }
                
                //Save last name
                if(userLastName != nil)
                {
                    myUser.setObject(userLastName!, forKey: "last_name")
                }
                
                // Save email address
                if(userEmail != nil)
                {

                    myUser.setObject(userEmail!, forKey: "email")
                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    
                    // Get Facebook profile picture
                    var userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    
                    let profilePictureUrl = NSURL(string: userProfile)
                    
                    let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
                    
                    if(profilePictureData != nil)
                    {
                        let profileFileObject = PFFile(data:profilePictureData!)
                        myUser.setObject(profileFileObject, forKey: "profile_picture")
                    }
                    
                    
                    myUser.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                        
                        if(success)
                        {
                            print("User details are now updated")
                        }
                        
                    })
                    
                }
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}