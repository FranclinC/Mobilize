//
//  NewProposal.swift
//  Mobilize
//
//  Created by Franclin Cabral on 03/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class NewProposal: UIViewController {

    @IBOutlet var proposalText: UITextView!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var heathButton: UIBarButtonItem!
    
    @IBOutlet var transportButton: UIBarButtonItem!
    
    @IBOutlet var healthBtn: UIButton!

    @IBOutlet var transportBtn: UIButton!
    @IBOutlet var educationButton: UIBarButtonItem!
    

    @IBOutlet var educationBtn: UIButton!
    @IBOutlet var securityButton: UIBarButtonItem!
    @IBOutlet var securityBtn: UIButton!
    
    @IBOutlet var cultureBtn: UIButton!
    @IBOutlet var cultureButton: UIBarButtonItem!
    
    @IBOutlet var constraintToolBarTop: NSLayoutConstraint!
    @IBOutlet weak var constraintToolBarBottom: NSLayoutConstraint!
    var constraintToolBarTopInitialValue : CGFloat = CGFloat()
    var constraintToolBarBottomInitialValue : CGFloat = CGFloat()

    //This is for a quick implementation, I will try to improve it later
    var h1 = 1
    var t1 = 1
    var e1 = 1
    var s1 = 1
    var c1 = 1
    
    //this is to count
    var categories = 0
    
    var categoriesName = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

        
        //save the initial value of the constraint
        

    }
    
    

    
    @IBAction func healthCategory(sender: AnyObject) {
        print("Health")
        
        if h1 == 1 && categories < 2{
            h1 = 0
            categories++
            let image = UIImage(named: "saude2")
            self.healthBtn.setImage(image, forState: UIControlState.Normal)
            self.categoriesName.append("Health")
            print(self.categoriesName)
        }else if h1 != 1{
            h1 = 1
            categories--
            self.categoriesName.removeAtIndex(self.categoriesName.indexOf("Health")!)
            print(self.categoriesName)
            let image = UIImage(named: "saude1")
            self.healthBtn.setImage(image, forState: UIControlState.Normal)
        }
        
        
    }
    
    @IBAction func transportCategory(sender: AnyObject) {
        print("Transport")
        if t1 == 1 && categories < 2{
            t1 = 0
            categories++
            let image = UIImage(named: "mobilidade2")
            self.transportBtn.setImage(image, forState: UIControlState.Normal)
            self.categoriesName.append("Transport")
            print(self.categoriesName)
        }else if t1 != 1 {
            t1 = 1
            categories--
            self.categoriesName.removeAtIndex(self.categoriesName.indexOf("Transport")!)
            print(self.categoriesName)
            let image = UIImage(named: "mobilidade1")
            self.transportBtn.setImage(image, forState: UIControlState.Normal)
        }
    }
   
    @IBAction func educationCategory(sender: AnyObject) {
        print("Education")
        if e1 == 1 && categories < 2{
            e1 = 0
            categories++
            let image = UIImage(named: "educacao2")
            self.educationBtn.setImage(image, forState: UIControlState.Normal)
            self.categoriesName.append("Education")
            print(self.categoriesName)
        }else if e1 != 1{
            e1 = 1
            categories--
            self.categoriesName.removeAtIndex(self.categoriesName.indexOf("Education")!)
            print(self.categoriesName)
            let image = UIImage(named: "educacao1")
            self.educationBtn.setImage(image, forState: UIControlState.Normal)
        }
    }

    
    @IBAction func securityCatgory(sender: AnyObject) {
        print("Security")
        if s1 == 1 && categories < 2{
            s1 = 0
            categories++
            let image = UIImage(named: "seguranca2")
            self.securityBtn.setImage(image, forState: UIControlState.Normal)
            self.categoriesName.append("Security")
            print(self.categoriesName)
        }else if s1 != 1{
            s1 = 1
            categories--
            self.categoriesName.removeAtIndex(self.categoriesName.indexOf("Security")!)
            print(self.categoriesName)
            let image = UIImage(named: "seguranca1")
            self.securityBtn.setImage(image, forState: UIControlState.Normal)
        }
    }
    
    
    @IBAction func cultureCategory(sender: AnyObject) {
        print("Culture")
        if c1 == 1 && categories < 2{
            c1 = 0
            categories++
            let image = UIImage(named: "cultura2")
            self.cultureBtn.setImage(image, forState: UIControlState.Normal)
            self.categoriesName.append("Culture")
            print(self.categoriesName)
        }else if c1 != 1{
            c1 = 1
            categories--
            self.categoriesName.removeAtIndex(self.categoriesName.indexOf("Culture")!)
            let image = UIImage(named: "cultura1")
            print(self.categoriesName)
            self.cultureBtn.setImage(image, forState: UIControlState.Normal)
        }
    }
    
    @IBAction func save(sender: AnyObject) {
        print("Saving data....")
        self.saveProposal()
    }
    
    func saveProposal (){
        
        let proposal = PFObject(className: "Proposals")
        let user = PFUser.currentUser()
        proposal["User"] = user
        proposal["ProposalText"] = proposalText.text
        proposal["Category"] = self.categoriesName
        proposal["Maturation"] = "BabyMob"
        
        //Remember to find a way to get the shortProposal, to be presented, without that, it will cause error opening the application
        //let i = (self.proposalText.text.endIndex) / 2
        
        //let shortProposal = self.proposalText.text
        //proposal["ShortProposal"] = shortProposal.substringToIndex(i)
        
        proposal.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                //Perform segue or pop
                self.navigationController?.popViewControllerAnimated(true)
                
            }else{
                //report the error
            }
        }
    }
    
    
    //This is to move up the toolbar with the keyboard
    func keyboardWillShow(notification: NSNotification) {

        print("Keyboard was called")
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.constraintToolBarBottom.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(notification: NSNotification){
        print("Hide keyboard...")
        //this will be used to place the toolbar where it belongs
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
