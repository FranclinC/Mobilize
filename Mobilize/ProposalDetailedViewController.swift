//
//  ProposalDetailed.swift
//  Mobilize
//
//  Created by Franclin Cabral on 18/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse
import CoreData

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
  var state: State?
  let moc = DataParameters().managedObjectContext
  let redColor = UIColor(colorLiteralRed: 196/255, green: 67/255, blue: 58/255, alpha: 1)
  let greenColor = UIColor(colorLiteralRed: 95/255, green: 170/255, blue: 89/255, alpha: 1)
  
  enum State {
    case Neutral
    case Agree
    case Disagree
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.commentTextField.delegate = self
    self.constraintHeightToolbar = self.toolBarHeightConstraint.constant
    self.tableView.estimatedRowHeight = 44
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    
    //load the array with comments
    self.loadComments()
    
    //Register nibs
    self.tableView.registerNib(UINib(nibName: "ProposalCell", bundle: nil), forCellReuseIdentifier: "proposalCellDetailed")
    self.tableView.registerNib(UINib(nibName: "CommentCountCell", bundle: nil), forCellReuseIdentifier: "commentCountCell")
    self.tableView.registerNib(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
  }
  
  override func viewDidAppear(animated: Bool) {
    
    
    var array = self.tableView.indexPathsForVisibleRows
    let cell : ProposalDetailedCell? = self.tableView.cellForRowAtIndexPath(array![0]) as? ProposalDetailedCell
    
    //Corner radius for bigview on top side
    let maskView = UIBezierPath(roundedRect: (cell?.bigView.bounds)!, byRoundingCorners: [UIRectCorner.TopLeft, UIRectCorner.TopRight], cornerRadii: CGSizeMake(9.0, 9.0))
    let mask = CAShapeLayer()
    mask.path = maskView.CGPath
    cell?.bigView.layer.mask = mask
    
    //Corner radius for button on bottom side
    let maskAgree = UIBezierPath(roundedRect: (cell?.agreeButton.bounds)!, byRoundingCorners: [UIRectCorner.BottomLeft] , cornerRadii: CGSizeMake(9.0, 9.0))
    let maskA = CAShapeLayer()
    maskA.path = maskAgree.CGPath
    cell?.agreeButton.layer.mask = maskA
    
    let maskDisagree = UIBezierPath(roundedRect: (cell?.disagreeButton.bounds)!, byRoundingCorners: [UIRectCorner.BottomRight] , cornerRadii: CGSizeMake(9.0, 9.0))
    let maskD = CAShapeLayer()
    maskD.path = maskDisagree.CGPath
    cell?.disagreeButton.layer.mask = maskD
    
    //Round corners for comment cell count
    let commentCell : CommentsCountCell? = self.tableView.cellForRowAtIndexPath(array![1]) as? CommentsCountCell
    
    let maskComment = UIBezierPath(roundedRect: (commentCell?.viewCount.bounds)!, byRoundingCorners: [UIRectCorner.TopLeft, UIRectCorner.TopRight], cornerRadii: CGSizeMake(9.0, 9.0))
    let maskC = CAShapeLayer()
    maskC.path = maskComment.CGPath
    commentCell?.viewCount.layer.mask = maskC
  }
  
  func loadComments() {
    let query = PFQuery(className: Constants.COMMENT)
    let innerQuery = PFQuery(className: Constants.PROPOSAL)
    
    innerQuery.whereKey(Constants.OBJECTID, equalTo: self.proposal.proposalId!)
    query.includeKey(Constants.USER)
    query.includeKey(Constants.PROPOSAL)
    query.whereKey(Constants.PROPOSAL, matchesQuery: innerQuery)
    self.comments.removeAll()
 
    query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?,
      error: NSError?) -> Void in
      if error == nil {
        self.commentsCount = (objects?.count)!
        for object in objects! {
          self.comments.append(object)
        }
      } else {
        print("Couldn't retrieve any comment in loadComments()")
      }
      
      self.tableView.reloadData()
    }
  }
  
  // MARK - @IBAction
  @IBAction func saveComment(sender: AnyObject) {
    let comment = PFObject(className: Constants.COMMENT)
    let user = PFUser.currentUser()

    comment[Constants.USER_WHO_COMMENT] = user
    comment[Constants.TEXT] = self.commentTextField.text
    let objProposal = PFObject(withoutDataWithClassName: Constants.PROPOSAL, objectId: self.proposal.proposalId)
    
    comment[Constants.PROPOSAL] = objProposal
    comment[Constants.STARS] = 0
    print(comment[Constants.USER_WHO_COMMENT])
    print(comment[Constants.TEXT])
    print(comment[Constants.PROPOSAL])
    
    comment.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      if success {
        self.loadComments()
      }else{
        print("error after trying deu erro")
      }
    }
  }
  
  @IBAction func sendComment(sender: UIButton) {
    self.commentTextField.text = ""
    self.commentTextField.endEditing(true)
  }
  
  //MARK: Keyboard delegate and methods
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
  
  func agree(sender: UIButton) {
    if sender.tag == 0 {
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
      
      if (self.state == .Neutral){ //Neutral
        //Must be the green color
        cell?.agreeButton.backgroundColor = UIColor(colorLiteralRed: 95/255, green: 170/255, blue: 89/255, alpha: 1)
        cell?.imageAgree.image = UIImage(named: "Proposta_Like.2")
        cell?.agreeCount.textColor = UIColor.whiteColor()
        cell?.agreeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell?.agreeCount.text = String(Int((cell?.agreeCount.text)!)! + 1)
        self.state = .Agree
        self.increment(true)
      }else if (self.state == .Disagree){ //On Disagreed and want to change to agree
        //Must be the green color
        cell?.agreeButton.backgroundColor = UIColor(colorLiteralRed: 95/255, green: 170/255, blue: 89/255, alpha: 1)
        cell?.imageAgree.image = UIImage(named: "Proposta_Like.2")
        cell?.agreeCount.textColor = UIColor.whiteColor()
        cell?.agreeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell?.agreeCount.text = String(Int((cell?.agreeCount.text)!)! + 1)
        
        //Change the color of the disagree button grey color
        cell?.disagreeButton.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell?.imageDisagree.image = UIImage(named: "Proposta_Dislike.1")
        cell?.disagreeCount.textColor = UIColor(colorLiteralRed: 143/255, green: 143/255, blue: 143/255, alpha: 1)
        cell?.disagreeButton.setTitleColor(UIColor(colorLiteralRed: 143/255, green: 143/255, blue: 143/255, alpha: 1), forState: UIControlState.Normal)
        cell?.disagreeCount.text = String(Int((cell?.disagreeCount.text)!)! - 1)
        self.state = .Agree
        self.increment(true)
        self.decrement(false)
      }else { //Already on agreed
        //Do nothing
      }
      
      let moc = DataParameters().managedObjectContext
      let fetch = NSFetchRequest(entityName: "ProposalAgreement")
      let predicate = NSPredicate(format: "proposal == %@ AND user == %@", proposalID, PFUser.currentUser()!.objectId!)
      fetch.predicate = predicate
      
      do {
        let fetchedResults = try moc.executeFetchRequest(fetch) as! [ProposalAgreement]
        fetchedResults.first?.agreeFlag = true
        fetchedResults.first?.disagreeFlag = false
      } catch {
        fatalError("Failure to fetch context: \(error)")
      }
      
      //Save our entire entity
      do {
        try moc.save()
      }catch {
        fatalError("Failure to save context: \(error)")
      }
      
    }
  }
  
  func disagree(sender: UIButton) {
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
      }
      
      if (self.state == .Neutral){
        //Must be the green color
        cell?.disagreeButton.backgroundColor = UIColor(colorLiteralRed: 196/255, green: 67/255, blue: 58/255, alpha: 1)
        cell?.imageDisagree.image = UIImage(named: "Proposta_Dislike.2")
        cell?.disagreeCount.textColor = UIColor.whiteColor()
        cell?.disagreeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell?.disagreeCount.text = String(Int((cell?.disagreeCount.text)!)! + 1)
        self.state = .Disagree
        self.increment(false)
      }else if (self.state == .Agree) {
        //Must be the green color
        cell?.disagreeButton.backgroundColor = UIColor(colorLiteralRed: 196/255, green: 67/255, blue: 58/255, alpha: 1)
        cell?.imageDisagree.image = UIImage(named: "Proposta_Dislike.2")
        cell?.disagreeCount.textColor = UIColor.whiteColor()
        cell?.disagreeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell?.disagreeCount.text = String(Int((cell?.disagreeCount.text)!)! + 1)
        
        //Change the color of the agree button
        cell?.agreeButton.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell?.imageAgree.image = UIImage(named: "Proposta_Like.1")
        cell?.agreeCount.textColor = UIColor(colorLiteralRed: 143/255, green: 143/255, blue: 143/255, alpha: 1)
        cell?.agreeButton.setTitleColor(UIColor(colorLiteralRed: 143/255, green: 143/255, blue: 143/255, alpha: 1), forState: UIControlState.Normal)
        cell?.agreeCount.text = String(Int((cell?.agreeCount.text)!)! - 1)
        self.state = .Disagree
        self.increment(false)
        self.decrement(true)
      }else {
        //Do nothing
      }
      
      let moc = DataParameters().managedObjectContext
      let fetch = NSFetchRequest(entityName: "ProposalAgreement")
      let predicate = NSPredicate(format: "proposal == %@ AND user == %@", proposalID, PFUser.currentUser()!.objectId!)
      fetch.predicate = predicate
      
      do {
        let fetchedResults = try moc.executeFetchRequest(fetch) as! [ProposalAgreement]
        fetchedResults.first?.agreeFlag = false
        fetchedResults.first?.disagreeFlag = true
      } catch {
        fatalError("Failure to fetch context: \(error)")
      }
      
      //Save our entire entity
      do {
        try moc.save()
      }catch {
        fatalError("Failure to save context: \(error)")
      }
    }
  }
  
  //MARK: - Cloude Code function calls
  func increment(option: Bool) {
    //Call to a function cloud code
    PFCloud.callFunctionInBackground("inc", withParameters: [Constants.OBJECTID : self.proposalID, "option": option], block: { (object:AnyObject?, error:NSError?) -> Void in
      if error != nil {
        //No error, i just took away the print
      }else {
        //Treat the error, it is working, i just took away the print
      }
    })
  }
  
  func decrement(option: Bool) {
    //Call to a function cloud code
    PFCloud.callFunctionInBackground("dec", withParameters: [Constants.OBJECTID : self.proposalID, "option" : option], block: { (object:AnyObject?, error:NSError?) -> Void in
      if error != nil {
        //No error, i just took away the print
      }else {
        //Treat the error, it is working, i just took away the print
      }
    })
  }
  
  //MARK: - Fetch functions
  func fetch(cell: ProposalDetailedCell){
    let moc = DataParameters().managedObjectContext
    let proposalFlag = NSFetchRequest(entityName: "ProposalAgreement")
    let predicate = NSPredicate(format: "proposal == %@ AND user == %@", proposalID, PFUser.currentUser()!.objectId!)
    proposalFlag.predicate = predicate
    
    do {
      let fetchedFlags = try moc.executeFetchRequest(proposalFlag) as! [ProposalAgreement]
      
      if (fetchedFlags.count == 0){
        //Then it is nil
        let entity = NSEntityDescription.insertNewObjectForEntityForName("ProposalAgreement", inManagedObjectContext: moc) as! ProposalAgreement
        
        entity.setValue(false, forKey: "agreeFlag")
        entity.setValue(false, forKey: "disagreeFlag")
        entity.setValue(proposalID, forKey: Constants.PROPOSAL)
        entity.setValue(PFUser.currentUser()?.objectId, forKey: Constants.USER)
        
        //Save our entire entity
        do {
          try moc.save()
        }catch {
          fatalError("Failure to save context: \(error)")
        }
        
      }else {
        print("It is not nil")
        //Change the color if it is necessary
        print("Valor da flag: \(fetchedFlags.first!.agreeFlag)")
        
        if (fetchedFlags.first!.agreeFlag){ //Agree
          print("é pra ta verde")
          print("This is just a test: \(cell.proposalText.text)")
          
          cell.agreeButton.backgroundColor = UIColor(colorLiteralRed: 95/255, green: 170/255, blue: 89/255, alpha: 1)
          cell.imageAgree.image = UIImage(named: "Proposta_Like.2")
          cell.agreeCount.textColor = UIColor.whiteColor()
          cell.agreeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
          self.state = .Agree
        }else if (fetchedFlags.first!.disagreeFlag){ //Disagree
          cell.disagreeButton.backgroundColor = UIColor(colorLiteralRed: 196/255, green: 67/255, blue: 58/255, alpha: 1)
          cell.imageDisagree.image = UIImage(named: "Proposta_Dislike.2")
          cell.disagreeCount.textColor = UIColor.whiteColor()
          cell.disagreeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
          self.state = .Disagree
        }else{ //Neutral
          //Do nothing here and maintain color
          self.state = .Neutral
        }
      }
    } catch {
      fatalError("Failure to fetch context: \(error)")
    }
  }
}

// MARK - UITableViewDataSource
extension ProposalDetailedViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 3 //3 sections, Proposal, comment count, comments
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
      
      self.fetch(cellProposal)
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
      let user : PFUser = (comments[indexPath.row][Constants.USER_WHO_COMMENT] as? PFUser)!
      print("Got the user")
      //Downloading user photo in background
      
      print("Pegando fotos")
      
      
      user.fetchIfNeededInBackgroundWithBlock({ (object: PFObject? , error: NSError?) -> Void in
        let userImageFile = user[Constants.PROFILE_PICTURE] as! PFFile
        print("Download Image, franclin testando")
        userImageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
          if error == nil {
            if let imageData = imageData {
              let image = UIImage(data:imageData)
              cell.userPic.image = image
            }
          }
        }
        
        cell.userName.text = (user[Constants.NAME] as? String)
      })
      
      cell.commentText.text = (self.comments[indexPath.row][Constants.TEXT] as? String)
      cell.commentTime.text = (self.comments[indexPath.row][Constants.CREATED_AT] as? String)
      
      //let starCount = self.comments[indexPath.row]["stars"] as! Int
      //cell.starCount.text = String(starCount)
      
      /*if starCount > 0 {
        cell.starImage.image = UIImage(named: "Proposta_Fav.2") //Yellow one
      }else{
        cell.starImage.image = UIImage(named: "Proposta_Fav.1") //Grey one
      }*/
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
