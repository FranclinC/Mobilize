//
//  AccountViewController.swift
//  Mobilize
//
//  Created by Franclin Cabral on 27/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //register nib
        self.tableView.registerNib(UINib(nibName: "AccountCell", bundle: nil), forCellReuseIdentifier: "accountCell")
        //register nib
        self.tableView.registerNib(UINib(nibName: "AccountLogOut", bundle: nil), forCellReuseIdentifier: "accountLogOut")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else if section == 2 {
            return 2
        }else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //this could be better but I am too lazy to do it now
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! ProposalDetailedCell
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! ProposalDetailedCell
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! ProposalDetailedCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountLogOut", forIndexPath: indexPath) as! ProposalDetailedCell
            return cell
        }
    }
    
    
    
}
