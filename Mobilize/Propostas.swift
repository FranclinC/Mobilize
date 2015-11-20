//
//  Propostas.swift
//  Mobilize
//
//  Created by Franclin Cabral on 19/10/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse


class Propostas: UIViewController, UITableViewDataSource, UITableViewDelegate, SingletonDelegate {

    @IBOutlet var tableView: UITableView!
    var proposals: [PFObject] = [PFObject]()
   
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var themesButton: UIBarButtonItem!
    @IBOutlet var newProposal: UIBarButtonItem!


    //var category : String = ""
    var maturation : String?
    

    var valueToPass : CustomCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedValues.filter = self
        maturation = "BabyMob"

        //Load data from parse
        self.loadProposals("BabyMob", filter: "All")
        
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
        //self.navigationController?.setNavigationBarHidden(true, animated: true) //Check with the designer if it will dissapear or just change its content, like title
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proposals.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("proposalCell", forIndexPath: indexPath) as! CustomCell
        print("Just a test")
        //Getting the user Object
        let user : PFUser = (proposals[indexPath.row]["User"] as? PFUser)!
        
        //Downloading user photo in background
        let userImageFile = user["profile_picture"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.userPicture.image = image
                }
            }
        }
        
        let fullName : String = (user["name"] as? String)!//(user["first_name"] as? String)! + " " + (user["last_name"] as? String)!
        cell.nameUser.text = fullName

        
        //Need to change that, it is with a bug
        //Category of the proposal: 1: Education, 2: Health, 3: Culture, 4: Transport, 5: Safety
        
        cell.category2.image = nil

        //New style of changing the cell
        var categories =  self.proposals[indexPath.row]["Category"] //Get the categories of the row
        
        //get the first flag, which is position 1, the 0 one is All
        if (categories[1] as! String) == "Education"{
            cell.category1.image = UIImage(named: "flag_educacao")
        }else if (categories[1] as! String) == "Health" {
            cell.category1.image = UIImage(named: "flag_saude")
        }else if (categories[1] as! String) == "Culture" {
            cell.category1.image = UIImage(named: "flag_cultura")
        }else if (categories[1] as! String) == "Safety" {
            cell.category1.image = UIImage(named: "flag_seguranca")
        }else if (categories[1] as! String) == "Transport" {
            cell.category1.image = UIImage(named: "flag_mobilidade")
        }
        
        
        //The second flag may exist
        if categories.count == 3 {
            if (categories[2] as! String) == "Education"{
                cell.category2.image = UIImage(named: "flag_educacao")
            }else if (categories[2] as! String) == "Health" {
                cell.category2.image = UIImage(named: "flag_saude")
            }else if (categories[2] as! String) == "Culture" {
                cell.category2.image = UIImage(named: "flag_cultura")
            }else if (categories[2] as! String) == "Safety" {
                cell.category2.image = UIImage(named: "flag_seguranca")
            }else if (categories[2] as! String) == "Transport" {
                cell.category2.image = UIImage(named: "flag_mobilidade")
            }
        }
        
        
        cell.fullProposal = self.proposals[indexPath.row]["ProposalText"] as? String
        cell.maturation = self.proposals[indexPath.row]["Maturation"] as? String
        
        
        cell.textProposal.text = self.proposals[indexPath.row]["ShortProposal"] as? String
        
        //Remember to set the size of the label
        cell.upVoteCount.text = self.proposals[indexPath.row]["UpVote"] as? String
        cell.againstVoteCount.text = self.proposals[indexPath.row]["DownVote"] as? String

        //Before send, create the object detailed
        cell.time = self.proposals[indexPath.row]["createdAt"] as? String
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! CustomCell
        
        valueToPass = currentCell
        self.performSegueWithIdentifier("proposalDetailed", sender: self)
    }

    func loadProposals(maturation: String, filter: String){
        
        let query = PFQuery(className:"Proposal")
        
        query.includeKey("User")
        //This is to get only the ones that are on stage one of maturation
        query.whereKey("Maturation", equalTo: maturation)
        query.whereKey("Category", equalTo: filter)
        self.proposals.removeAll()

        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Got the objects")
                //Now i get the array of objects
                print(objects)
                for object in objects! {
                    self.proposals.append(object)
                    print(self.proposals[0]["ShortProposal"])
                }
            }else {
                print("Couldn't retrieve any object")
            }
            
            self.tableView.reloadData()
            
            
        }
    }
    
    
    @IBAction func makeProposal(sender: AnyObject) {
        self.performSegueWithIdentifier("makeProposal", sender: nil)
    }
    
    
    
    
    /* This is just to remember how to use an array of pointers
    You can enter an array of these, comma separated, i.e.
    
    [{"__type":"Pointer","className":"TargetClassNameHere","objectId":"actualObjectIdHere"},{"__type":"Pointer","className":"TargetClassNameHere","objectId":"actualObjectIdHere"}]
    
    */

    
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
    
    
    //This sends data to the ProposalDetailed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "proposalDetailed" {
            
            
            
            let vc = segue.destinationViewController as! ProposalDetailed
            vc.proposal = valueToPass
        }
        
    }

}
