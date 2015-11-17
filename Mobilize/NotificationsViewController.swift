//
//  NotificationViewController.swift
//  Mobilize
//
//  Created by Miguel Araújo on 11/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var notification = ["notificacao1", "notificao2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}