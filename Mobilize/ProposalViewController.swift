//
//  Propostas.swift
//  Mobilize
//
//  Created by Franclin Cabral on 19/10/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse


class ProposalViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var segmentedControl: UISegmentedControl!
  @IBOutlet var themesButton: UIBarButtonItem!
  @IBOutlet var newProposal: UIBarButtonItem!
  
  
  @IBOutlet var loading: UIActivityIndicatorView!
  
  var proposals: [PFObject] = [PFObject]()
  var maturation : String?
  var valueToPass : CustomCell!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SharedValues.filter = self
    maturation = "BabyMob"
    
    //self.loading.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 125
    
    //Load data from parse
    //self.loadProposals("BabyMob", filter: "All")
    
    //register nib
    self.tableView.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "proposalCell")
    
    themesButton.target = self.revealViewController()
    themesButton.action = Selector("revealToggle:")
    
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.tabBarController?.navigationItem.titleView = segmentedControl //This is to put the segment control in the navbar
    self.tabBarController?.navigationItem.leftBarButtonItem = themesButton
    self.tabBarController?.navigationItem.rightBarButtonItem = newProposal
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 0.9)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(true)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    //Load data from parse
    self.segmentedControl.selectedSegmentIndex = 0 //Just because it was loading BabyMob on Mob maturation
    self.loadProposals("BabyMob", filter: "All")
  }
  

  
  
  
  func loadProposals(maturation: String, filter: String){
    self.view.bringSubviewToFront(self.loading)
    self.loading.startAnimating()
    let query = PFQuery(className: Constants.PROPOSAL)
    
    query.includeKey(Constants.USER)
    //This is to get only the ones that are on stage one of maturation
    query.whereKey("Maturation", equalTo: maturation)
    query.whereKey("Category", equalTo: filter)
    self.proposals.removeAll()
    
    query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
      if error == nil {
        print("Got the objects")
        //Now i get the array of objects
        
        for object in objects! {
          
          self.proposals.append(object)
        }
      }else {
        self.loading.stopAnimating()
        let alert = UIAlertController(title: "Alerta!", message: "Algo estranho aconteceu! Por favor, verifique se está conectado a internet!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
      }
      
      self.tableView.reloadData()
      self.loading.stopAnimating()
      
      
    }
  }
  
  @IBAction func makeProposal(sender: AnyObject) {
    self.performSegueWithIdentifier("makeProposal", sender: nil)
  }
  
  @IBAction func maturation(sender: UISegmentedControl) {
    switch segmentedControl.selectedSegmentIndex {
    case 0:
      self.maturation = "BabyMob"
      print("Maturation: BabyMob")
      self.loadProposals("BabyMob", filter: "All")
      
    case 1:
      self.maturation = "Mob"
      print("Maturation: Mob")
      self.loadProposals("Mob", filter: "All")
    case 2:
      self.maturation = "MobDick"
      print("Maturation: Modick")
      self.loadProposals("MobDick", filter: "All")
    default:
      break
    }
  }
  
  func changeFilter(category: String) {
    self.loadProposals(self.maturation!, filter: category)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "proposalDetailed" {
      let vc = segue.destinationViewController as! ProposalDetailedViewController
      vc.proposal = valueToPass
      vc.proposalID = valueToPass.proposalId!
    }
  }
}

// MARK - UITableViewDataSource
extension ProposalViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return proposals.count
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("proposalCell", forIndexPath: indexPath) as! CustomCell
    let user : PFUser = (proposals[indexPath.row][Constants.USER] as? PFUser)!
    
    //Downloading user photo in background
    let userImageFile = user[Constants.PROFILE_PICTURE] as! PFFile
    userImageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
      if error == nil {
        if let imageData = imageData {
          let image = UIImage(data:imageData)
          cell.userPicture.image = image
        }
      }
    }
    
    let fullName : String = (user[Constants.NAME] as? String)!//(user["first_name"] as? String)! + " " + (user["last_name"] as? String)!
    cell.nameUser.text = fullName
    
    cell.category2.image = nil
    
    //New style of changing the cell
    let categories =  self.proposals[indexPath.row]["Category"] //Get the categories of the row
    
    //get the first flag, which is position 1, the 0 one is All
    if (categories[1] as! String) == "Education"{
      cell.category1.image = UIImage(named: "flag_educacao")
    }else if (categories[1] as! String) == "Health" {
      cell.category1.image = UIImage(named: "flag_saude")
    }else if (categories[1] as! String) == "Culture" {
      cell.category1.image = UIImage(named: "flag_cultura")
    }else if (categories[1] as! String) == "Security" {
      cell.category1.image = UIImage(named: "flag_seguranca")
    }else if (categories[1] as! String) == "Transport" {
      cell.category1.image = UIImage(named: "flag_mobilidade")
    }
    
    if categories.count == 3 {
      if (categories[2] as! String) == "Education"{
        cell.category2.image = UIImage(named: "flag_educacao")
      }else if (categories[2] as! String) == "Health" {
        cell.category2.image = UIImage(named: "flag_saude")
      }else if (categories[2] as! String) == "Culture" {
        cell.category2.image = UIImage(named: "flag_cultura")
      }else if (categories[2] as! String) == "Security" {
        cell.category2.image = UIImage(named: "flag_seguranca")
      }else if (categories[2] as! String) == "Transport" {
        cell.category2.image = UIImage(named: "flag_mobilidade")
      }
    }
    
    cell.fullProposal = self.proposals[indexPath.row][Constants.PROPOSAL_TEXT] as? String
    cell.maturation = self.proposals[indexPath.row][Constants.MATURATION] as? String
    cell.textProposal.text = self.proposals[indexPath.row][Constants.SHORT_PROPOSAL] as? String
    print("This is just a test \(self.proposals[indexPath.row][Constants.UPVOTE])")
    cell.upVoteCount.text = String(self.proposals[indexPath.row][Constants.UPVOTE])
    cell.againstVoteCount.text = String(self.proposals[indexPath.row][Constants.DOWNVOTE])
    cell.time = self.proposals[indexPath.row][Constants.CREATED_AT] as? String
    cell.proposalId = self.proposals[indexPath.row].objectId! as String
    print("proposal id: \(cell.proposalId)")
    let timeStamp = self.proposals[indexPath.row].createdAt
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd/mm/YY hh:mm"
    let dateString = dateFormatter.stringFromDate(timeStamp!)
    cell.time = dateString
    
    return cell
  }
}

// MARK - UITableViewDelegate
extension ProposalViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let indexPath = tableView.indexPathForSelectedRow
    let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! CustomCell
    
    valueToPass = currentCell
    self.tableView.deselectRowAtIndexPath(indexPath!, animated: true)
    self.performSegueWithIdentifier("proposalDetailed", sender: self)
  }
}

// MARK - SingletonDelegate
extension ProposalViewController: SingletonDelegate {
  
}
