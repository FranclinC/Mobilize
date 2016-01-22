//
//  NewProposal.swift
//  Mobilize
//
//  Created by Franclin Cabral on 03/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class NewProposalViewController: UIViewController {
  @IBOutlet var proposalText: UITextView!
  @IBOutlet var toolBar: UIToolbar!
  @IBOutlet var educationButton: UIBarButtonItem!
  @IBOutlet var heathButton: UIBarButtonItem!
  @IBOutlet var transportButton: UIBarButtonItem!
  @IBOutlet var securityButton: UIBarButtonItem!
  @IBOutlet var cultureButton: UIBarButtonItem!
  @IBOutlet var healthBtn: UIButton!
  @IBOutlet var transportBtn: UIButton!
  @IBOutlet var educationBtn: UIButton!
  @IBOutlet var securityBtn: UIButton!
  @IBOutlet var cultureBtn: UIButton!
  @IBOutlet var toolBarView: UIView!
  @IBOutlet var backButtonNavigator: UINavigationItem!
  @IBOutlet var constraintToolBarHeight: NSLayoutConstraint!
  @IBOutlet var constraintToolBarBottom: NSLayoutConstraint!
  @IBOutlet var constraintToolBarTop: NSLayoutConstraint!
  
  var keyboardDismissSwipeGesture: UISwipeGestureRecognizer?
  var initialConstraint : CGFloat?
  var h1 = 1
  var t1 = 1
  var e1 = 1
  var s1 = 1
  var c1 = 1
  var categories = 0
  var categoriesName = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.proposalText.delegate = self
    self.initialConstraint = constraintToolBarHeight.constant
    proposalText.text = "Digite aqui a sua proposta"
    proposalText.textColor = UIColor.lightGrayColor()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.navigationItem.backBarButtonItem?.title = ""
  }
  
  @IBAction func healthCategory(sender: AnyObject) {
    print("health")
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
    if (self.categoriesName.count == 0){
      let alert = UIAlertController(title: "Alerta!", message: "Você deve adcionar uma categoria para poder prôpor!", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }else{
      print("Saving data....")
      self.saveProposal()
    }
  }
  
  func saveProposal() {
    self.categoriesName.insert("All", atIndex: 0) //All proposal must have an All flag, inthe position 0
    let proposal = PFObject(className: Constants.PROPOSAL)
    let user = PFUser.currentUser()
    proposal[Constants.USER] = user
    proposal[Constants.PROPOSAL_TEXT] = proposalText.text
    proposal["Category"] = self.categoriesName
    proposal[Constants.MATURATION] = "BabyMob"
    proposal[Constants.SHORT_PROPOSAL] = proposalText.text //This should not be like that
    proposal[Constants.UPVOTE] = 0
    proposal[Constants.DOWNVOTE] = 0
    
    proposal.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      if success {
        self.navigationController?.popViewControllerAnimated(true)
      }else{
      }
    }
  }
  
  func keyboardWillShow(notification: NSNotification) {
    let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    print(frame.height)
    self.view.layoutIfNeeded()
    UIView.animateWithDuration(0.5, animations: {
      self.constraintToolBarHeight.constant = frame.height + self.toolBarView.frame.height
      self.constraintToolBarBottom.constant = frame.height
      self.view.layoutIfNeeded()
      }, completion: nil)
    
    if keyboardDismissSwipeGesture == nil {
      print("Add gesture")
      keyboardDismissSwipeGesture = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard:")
      keyboardDismissSwipeGesture?.direction = UISwipeGestureRecognizerDirection.Down
      self.view.addGestureRecognizer(keyboardDismissSwipeGesture!)
    }
  }
  
  func KeyboardWillHide(notification: NSNotification){
    self.view.layoutIfNeeded()
    UIView.animateWithDuration(0.5, animations: { () -> Void in
      self.constraintToolBarHeight.constant = self.initialConstraint!
      self.constraintToolBarBottom.constant = 0
      self.view.layoutIfNeeded()
      }, completion: nil)
    
    if keyboardDismissSwipeGesture != nil {
      self.view.removeGestureRecognizer(keyboardDismissSwipeGesture!)
      keyboardDismissSwipeGesture = nil
    }
  }
  
  func dismissKeyboard(sender: AnyObject) {
    self.proposalText?.resignFirstResponder()
  }
}

// MARK - UITextViewDelegate
extension NewProposalViewController: UITextViewDelegate {
  func textViewDidBeginEditing(textView: UITextView) {
    if textView.textColor == UIColor.lightGrayColor() {
      textView.text = nil
      textView.textColor = UIColor.blackColor()
    }
  }
  
  func textViewDidEndEditing(textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Digite aqui a sua proposta"
      textView.textColor = UIColor.lightGrayColor()
    }
  }
}