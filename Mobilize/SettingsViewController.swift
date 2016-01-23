//
//  SettingsViewController.swift
//  Mobilize
//
//  Created by Miguel Araújo on 11/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  var countComment : NSNumber?
  var myCommentsCount : Int32?
  var myProposals : Int?
  var myMobProposals: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadUserStats()
    self.tableView.estimatedRowHeight = 44
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    self.tableView.registerNib(UINib(nibName: "SettingsPicture",
      bundle: nil), forCellReuseIdentifier: "settingsPicture")
    self.tableView.registerNib(UINib(nibName: "SettingsGroup1",
      bundle: nil), forCellReuseIdentifier: "settingsGroup1")
    self.tableView.registerNib(UINib(nibName: "SettingsGroup2",
      bundle: nil), forCellReuseIdentifier: "settingsGroup2")
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.tabBarController?.navigationItem.leftBarButtonItem = nil
    self.tabBarController?.navigationItem.rightBarButtonItem = nil
    self.tabBarController?.navigationItem.hidesBackButton = true
    self.tabBarController?.navigationItem.titleView = nil
    self.tabBarController?.navigationItem.title = "Configurações"
    self.tabBarController?.navigationItem.titleView?.tintColor =
      UIColor(colorLiteralRed: 70/255, green: 97/255, blue: 157/255, alpha: 1)
  }
  
  func loadUserStats() {
    let user = PFUser.currentUser()
    let query = PFQuery(className: Constants.COMMENT)
    query.whereKey(Constants.USER_WHO_COMMENT, equalTo: user!)
    
    query.countObjectsInBackgroundWithBlock { (count: Int32,
      error: NSError?) -> Void in
      if error == nil {
        self.myCommentsCount = count
        print("Olha ai quantos tenho\(count)")
      }
    }
    
    //Find the proposals the user created
    let query2 = PFQuery(className: Constants.PROPOSAL)
    query2.whereKey(Constants.USER, equalTo: user!)
    query2.findObjectsInBackgroundWithBlock { (objects: [PFObject]?,
      error: NSError?) -> Void in
      self.myProposals = objects?.count
      
      //This could be better but I am in a hurry
      for object in objects! {
        if (object["Maturation"] as! String) == "MobDick"{
          self.myMobProposals = self.myMobProposals! + 1 //Add one
        }
      }
    }
  }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cellUser = tableView.dequeueReusableCellWithIdentifier("settingsPicture",
        forIndexPath: indexPath) as! SettingsPicture
      let user = PFUser.currentUser()
      
      if user![Constants.PROFILE_PICTURE] == nil {
        cellUser.userPicture.image = UIImage(named: "perfil")
      }else {
        
        let userImageFile = user![Constants.PROFILE_PICTURE] as! PFFile
        userImageFile.getDataInBackgroundWithBlock { (imageData: NSData?,
          error: NSError?) -> Void in
          if error == nil {
            if let imageData = imageData {
              let image = UIImage(data:imageData)
              cellUser.userPicture.image = image
            }
          }
        }
        
      }
      cellUser.userName.text = user![Constants.NAME] as? String
      
      let timeStamp = user?.createdAt
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "MMM/YY"//"dd/mm/YY hh:mm"
      let dateString = dateFormatter.stringFromDate(timeStamp!)
      cellUser.contributionLabel.text = "Contribui desde " + dateString
      return cellUser
    }else {
      let cellGroup2 = tableView.dequeueReusableCellWithIdentifier("settingsGroup2",
        forIndexPath: indexPath) as! SettingsGroup2
      
      cellGroup2.imageIcon.image = UIImage(named: "Config_Config")
      cellGroup2.labelCell.text = "Ajustes da Conta"
      cellGroup2.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
      return cellGroup2
    }
  }
  
  func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    }else{
      return 1
    }
  }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("Account settings")
    print(indexPath.row)
    if indexPath.section == 1 { //section should be 2, but small change to send to appstore
      if indexPath.row == 0 {
        print("Segue 1")
        self.performSegueWithIdentifier("account", sender: nil)
      }else if indexPath.row == 1 {
        print("Segue 2")
        self.performSegueWithIdentifier("notificationSettings", sender: nil)
      }
    }
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 || section == 1 {
      print("Entrei no section size")
      return CGFloat.min
    }else {
      return 10
    }
  }
}