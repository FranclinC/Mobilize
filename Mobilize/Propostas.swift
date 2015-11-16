//
//  Propostas.swift
//  Mobilize
//
//  Created by Franclin Cabral on 19/10/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse


class Propostas: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var proposals: [PFObject] = [PFObject]()
   
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var themesButton: UIBarButtonItem!
    @IBOutlet var newProposal: UIBarButtonItem!


    var category : String = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print("Teste de valor: \(category)")
        // Do any additional setup after loading the view.

        if category == "" { //In case there is not a value yet, When the app just start
            self.loadProposals("BabyMob") //This is the parameter search, i must add a new parameter for the category
            print("Entrei na primeira categoria")
        }else{
            self.loadProposals("BabyMob")
            print("Entrei na segunda categoria")
        }
        
        
        
        
        //self.loadProposals("BabyMob")
        self.tableView.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "proposalCell")
        
        
        themesButton.target = self.revealViewController()
        themesButton.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        var tabBar = self.tabBarController //Instead of passing each value, just pass the tab bar, it will have the values there. That does not work, i already tried
        
        self.tabBarController?.navigationItem.titleView = segmentedControl //This is to put the segment control in the navbar
        self.tabBarController?.navigationItem.leftBarButtonItem = themesButton
        self.tabBarController?.navigationItem.rightBarButtonItem = newProposal
        super.viewWillAppear(true)
        //self.navigationItem.setHidesBackButton(true, animated: false)
        //Putting the reference of the items in the singleton
        //SharedValues.sharedInstance.setThemesButton(self.themesButton)
        //SharedValues.sharedInstance.setSegmentedControl(self.segmentedControl)
        //SharedValues.sharedInstance.setNewProposal(self.newProposal)
        //SharedValues.sharedInstance.setTabBar(tabBar!)
        //SharedValues.sharedInstance.settableView(self.tableView)

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 //It can be more than one section, one per categoy??
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(proposals.count)
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
        
        let fullName : String = (user["first_name"] as? String)! + " " + (user["last_name"] as? String)!
        cell.nameUser.text = fullName

        
        //Need to change that
        //Category of the proposal: 1: Education, 2: Health, 3: Culture, 4: Transport, 5: Safety
        let categories = self.proposals[indexPath.row]["Category"]
        print(categories[0])
        if (categories[0] as! String) == "Education" {
            cell.category1.image = UIImage(named: "flag_educacao")
        }else if (categories[0] as! String) == "Health" {
            cell.category1.image = UIImage(named: "flag_saude")
        }else if (categories[0] as! String) == "Culture" {
            cell.category1.image = UIImage(named: "flag_cultura")
        }else if (categories[0] as! String) == "Safety" {
            cell.category1.image = UIImage(named: "flag_seguranca")
        }else{
            cell.category1.image = UIImage(named: "flag_mobilidade")
        }
        
        if ((categories[1] as! String) == "Education") && (categories.count >= 2) {
            cell.category2.image = UIImage(named: "flag_educacao")
        }else if ((categories[1] as! String) == "Health") && (categories.count >= 2) {
            cell.category2.image = UIImage(named: "flag_saude")
        }else if ((categories[1] as! String) == "Culture") && (categories.count >= 2) {
            cell.category2.image = UIImage(named: "flag_cultura")
        }else if ((categories[1] as! String) == "Safety") && (categories.count >= 2) {
            cell.category2.image = UIImage(named: "flag_seguranca")
        }else{
            cell.category2.image = UIImage(named: "flag_mobilidade")
        }

        
        
        
        cell.textProposal.text = self.proposals[indexPath.row]["ShortProposal"] as? String
        
        //Remember to set the size of the label
        cell.upVoteCount.text = self.proposals[indexPath.row]["UpVote"] as? String
        cell.againstVoteCount.text = self.proposals[indexPath.row]["DownVote"] as? String
        //cell.upVoteCount.text = self.proposals[indexPath.row]["UpVote"] as? String
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("proposalDetailed", sender: self)
        
    }

    func loadProposals(maturation: String){
        
        let query = PFQuery(className:"Proposals")
        
        query.includeKey("User")
        //This is to get only the ones that are on stage one of maturation
        query.whereKey("Maturation", equalTo: maturation)

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
            self.loadProposals("BabyMob")
            
        case 1:
            self.loadProposals("Mob")
        case 2:
            self.loadProposals("MobDick")
        default:
            break
        }
    }
    

}
