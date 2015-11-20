//
//  ProposalDetailed.swift
//  Mobilize
//
//  Created by Franclin Cabral on 18/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class ProposalDetailed: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    
    
    

    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var tableView: UITableView!
   
    @IBOutlet var toolBar: UIView!
    @IBOutlet var toolBarHeightConstraint: NSLayoutConstraint!

    @IBOutlet var commentButton: UIButton!
    
    var comments : [PFObject] = [PFObject]()
    var tapGesture : UITapGestureRecognizer?
    var constraintHeightToolbar : CGFloat?
    
    var proposal : CustomCell = CustomCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentTextField.delegate = self
        self.constraintHeightToolbar = self.toolBarHeightConstraint.constant
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        
        //Register nibs
        self.tableView.registerNib(UINib(nibName: "ProposalCell", bundle: nil), forCellReuseIdentifier: "proposalCellDetailed")
        self.tableView.registerNib(UINib(nibName: "CommentCountCell", bundle: nil), forCellReuseIdentifier: "commentCountCell")
        self.tableView.registerNib(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    //MARK: - TableView Delegate Methods
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
            
            cellProposal.proposalText.text = self.proposal.fullProposal
            cellProposal.userName.text = self.proposal.nameUser.text
            cellProposal.userPic.image = self.proposal.userPicture.image
            cellProposal.disagreeCount.text = self.proposal.againstVoteCount.text
            cellProposal.agreeCount.text = self.proposal.upVoteCount.text
            cellProposal.dateTime.text = self.proposal.time
            cellProposal.category1.image = self.proposal.category1.image //It must have at least one category
            
            if self.proposal.category2 != nil{ //The second one is opitional
                    cellProposal.category2.image = self.proposal.category2.image
            }            
            
            return cellProposal
        }else if indexPath.section == 1 {
            let cellCommentCount = tableView.dequeueReusableCellWithIdentifier("commentCountCell", forIndexPath: indexPath) as! CommentsCountCell
            return cellCommentCount
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentCell
            
            return cell
        }
    }
    
    
    //MARK:  Comment Functions
    @IBAction func sendComment(sender: UIButton) {
        
        
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
}
