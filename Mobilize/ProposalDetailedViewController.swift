//
//  ProposalDetailed.swift
//  Mobilize
//
//  Created by Franclin Cabral on 18/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class ProposalDetailedViewController: UIViewController {
  @IBOutlet var commentTextField: UITextField!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var toolBar: UIView!
  @IBOutlet var toolBarHeightConstraint: NSLayoutConstraint!
  @IBOutlet var commentButton: UIButton!
  
  var comments: [PFObject] = [PFObject]()
  var tapGesture: UITapGestureRecognizer?
  var constraintHeightToolbar: CGFloat?
  var proposal: CustomCell = CustomCell()
  var commentsCount: Int = 0
  var proposalID: String!
  var agreeClicked: Bool?
  var proposalAgreement: ProposalAgreement?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.commentTextField.delegate = self
    self.constraintHeightToolbar = self.toolBarHeightConstraint.constant
    self.tableView.estimatedRowHeight = 44
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    print("Load array with data")
    self.loadComments()
    self.tableView.registerNib(UINib(nibName: "ProposalCell", bundle: nil), forCellReuseIdentifier: "proposalCellDetailed")
    self.tableView.registerNib(UINib(nibName: "CommentCountCell", bundle: nil), forCellReuseIdentifier: "commentCountCell")
    self.tableView.registerNib(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
  }
  
  @IBAction func sendComment(sender: UIButton) {
    self.commentTextField.text = ""
    self.commentTextField.endEditing(true)
  }
  
  func keyboardWillShow(notification: NSNotification) {
    let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    
    print(frame.height)
    self.view.layoutIfNeeded()
    UIView.animateWithDuration(0.5, animations: {
      self.toolBarHeightConstraint.constant = frame.height + self.toolBar.frame.height
      self.view.layoutIfNeeded()
      }, completion: nil)
    
    if tapGesture == nil {
      print("Add gesture")
      tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
      self.tableView.addGestureRecognizer(tapGesture!)
    }
  }
  
  func KeyboardWillHide(notification: NSNotification){
    self.view.layoutIfNeeded()
    UIView.animateWithDuration(0.5, animations: { () -> Void in
      self.toolBarHeightConstraint.constant = self.constraintHeightToolbar!
      self.view.layoutIfNeeded()
      }, completion: nil)
    if tapGesture != nil {
      self.tableView.removeGestureRecognizer(tapGesture!)
      tapGesture = nil
    }
  }
  
  func dismissKeyboard(sender: AnyObject) {
    self.commentTextField.resignFirstResponder()
  }
  
  func loadComments() {
    let query = PFQuery(className:"Comment")
    
    let innerQuery = PFQuery(className: "Proposal")
    innerQuery.whereKey("objectId", equalTo: self.proposal.proposalId!)
    
    query.includeKey("User")
    query.includeKey("Proposal")
    //This is to get only the ones that are on stage one of maturation
    print("proposta \(self.proposal.proposalId!)")
    query.whereKey("Proposal", matchesQuery: innerQuery)
    self.comments.removeAll()
    print("Go get the comments")
    query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
      if error == nil {
        print(objects)
        self.commentsCount = (objects?.count)!
        for object in objects! {
          self.comments.append(object)
        }
      }else {
        print("Couldn't retrieve any comment")
      }
      
      self.tableView.reloadData()
    }
  }
  
  @IBAction func saveComment(sender: AnyObject) {
    let comment = PFObject(className: "Comment")
    let user = PFUser.currentUser()
    print("proposal id franclin: \(user)")
    comment["UserWhoComment"] = user
    comment["text"] = self.commentTextField.text
    let objProposal = PFObject(withoutDataWithClassName: "Proposal", objectId: self.proposal.proposalId)
    
    comment["Proposal"] = objProposal
    comment["stars"] = 0
    print(comment["UserWhoComment"])
    print(comment["text"])
    print(comment["Proposal"])
    
    comment.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      if success {
        PFCloud.callFunctionInBackground("hello", withParameters: nil) { results, error in
          if error != nil {
            print("Deu erro no cloud code")
          } else {
            print("Deu certo o cloud code")
          }
        }
        
        self.loadComments()
        print("deu certo")
      }else{
        print("deu erro")
      }
    }
  }
  
  func agree(sender: UIButton) {
    if sender.tag == 0 {
      print("Peguei o botão")
      var array = self.tableView.indexPathsForVisibleRows
      
      let cell : ProposalDetailedCell? = self.tableView.cellForRowAtIndexPath(array![0]) as? ProposalDetailedCell
      
      let user : PFUser = PFUser.currentUser()!
      print(user.objectId!)
      print(self.proposalID)
      
      let flags : [ProposalAgreement]? = (self.proposalAgreement?.fetch(user.objectId!, proposal: self.proposalID))
      
      if ((flags?[0].agreeFlag) != nil) {
        print("ta verdadeiro")
      }else {
        print("é falso")
        //activate the flag that can change the button
      }
      
      cell?.agreeButton.backgroundColor = UIColor(colorLiteralRed: 95/255, green: 170/255, blue: 89/255, alpha: 1)
      cell?.imageAgree.image = UIImage(named: "Proposta_Like.2")
      cell?.agreeCount.textColor = UIColor.whiteColor()
      cell?.agreeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
      cell?.agreeCount.text = String(Int((cell?.agreeCount.text)!)! + 1)
    }
  }
  
  func disagree(sender: UIButton){
    if sender.tag == 0 {
      print("Discordo")
      
      var array = self.tableView.indexPathsForVisibleRows
      
      let cell : ProposalDetailedCell? = self.tableView.cellForRowAtIndexPath(array![0]) as? ProposalDetailedCell
      
      let user : PFUser = PFUser.currentUser()!
      print(user.objectId!)
      print(self.proposalID)
      
      let flags : [ProposalAgreement]? = (self.proposalAgreement?.fetch(user.objectId!, proposal: self.proposalID))
      
      if ((flags?[0].agreeFlag) != nil) {
        print("ta verdadeiro")
      }else {
        print("é falso")
        //activate the flag that can change the button
      }
      
      cell?.disagreeButton.backgroundColor = UIColor(colorLiteralRed: 196/255, green: 67/255, blue: 58/255, alpha: 1)
      cell?.imageDisagree.image = UIImage(named: "Proposta_Dislike.2")
      cell?.disagreeCount.textColor = UIColor.whiteColor()
      cell?.disagreeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
      cell?.disagreeCount.text = String(Int((cell?.disagreeCount.text)!)! + 1)
    }
  }
}

// MARK - UITableViewDataSource
extension ProposalDetailedViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("How many sections: \(section)")
    if section == 0 {
      print("Section \(section)")
      return 1 //The cell of proposal detailed
    }
    else if section == 1 {
      print("Section \(section)")
      return 1 //Cell with the count of comments
    } else {
      print("Comment count \(comments.count)")
      return comments.count //Cells with the real comment
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    print("Que celula é essa? \(indexPath.row)")
    if indexPath.section == 0 {
      let cellProposal = tableView.dequeueReusableCellWithIdentifier("proposalCellDetailed", forIndexPath: indexPath) as! ProposalDetailedCell
      self.proposalID = self.proposal.proposalId!
      cellProposal.proposalText.text = self.proposal.fullProposal
      print("Proposta id decio: \(self.proposalID!)")
      cellProposal.userName.text = self.proposal.nameUser.text
      cellProposal.userPic.image = self.proposal.userPicture.image
      cellProposal.disagreeCount.text = self.proposal.againstVoteCount.text
      cellProposal.agreeCount.text = self.proposal.upVoteCount.text
      cellProposal.dateTime.text = self.proposal.time
      cellProposal.category1.image = self.proposal.category1.image //It must have at least one category
      
      if self.proposal.category2 != nil{ //The second one is opitional
        cellProposal.category2.image = self.proposal.category2.image
      }
      
      cellProposal.agreeButton.tag = indexPath.row
      cellProposal.agreeButton.addTarget(self, action: Selector("agree:"), forControlEvents: UIControlEvents.TouchUpInside)
      cellProposal.disagreeButton.tag = indexPath.row
      cellProposal.disagreeButton.addTarget(self, action: Selector("disagree:"), forControlEvents: .TouchUpInside)
      
      return cellProposal
    }else if indexPath.section == 1 {
      print("Comment count cell")
      let cellCommentCount = tableView.dequeueReusableCellWithIdentifier("commentCountCell", forIndexPath: indexPath) as! CommentsCountCell
      cellCommentCount.commentCount.text = String(self.commentsCount)
      print("How many comements \(self.commentsCount)")
      
      return cellCommentCount
    }else{
      print("Let's get the comments")
      let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentCell
      print("Get the user")
      let user : PFUser = (comments[indexPath.row]["UserWhoComment"] as? PFUser)!
      print("Got the user")
      print("Pegando fotos")
      
      user.fetchIfNeededInBackgroundWithBlock({ (object: PFObject? , error: NSError?) -> Void in
        let userImageFile = user["profile_picture"] as! PFFile
        print("Download Image, franclin testando")
        userImageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
          if error == nil {
            if let imageData = imageData {
              let image = UIImage(data:imageData)
              cell.userPic.image = image
            }
          }
        }
        
        cell.userName.text = (user["name"] as? String)
      })
      
      
      cell.commentText.text = (self.comments[indexPath.row]["text"] as? String)
      cell.commentTime.text = (self.comments[indexPath.row]["createdAt"] as? String)
      
      let starCount = self.comments[indexPath.row]["stars"] as! Int
      cell.starCount.text = String(starCount)
      
      if starCount > 0 {
        cell.starImage.image = UIImage(named: "Proposta_Fav.2") //Yellow one
      }else{
        cell.starImage.image = UIImage(named: "Proposta_Fav.1") //Grey one
      }
      cell.userName.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds)
      cell.commentText.numberOfLines = 0
      
      let timeStamp = self.comments[indexPath.row].createdAt
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "dd/mm/YY hh:mm"
      let dateString = dateFormatter.stringFromDate(timeStamp!)
      cell.commentTime.text = dateString
      
      return cell
    }
  }
}

// MARK - UITableViewDelegate
extension ProposalDetailedViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}

// MARK - UITextFieldDelegate
extension ProposalDetailedViewController: UITextFieldDelegate {
  
}
