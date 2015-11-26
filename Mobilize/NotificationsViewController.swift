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
    var notification = ["Miguel, isso é so um array estatico", "Tem que ver como vai ser recebido"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register nib
        self.tableView.registerNib(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "notificationCell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.titleView = nil
        
        self.tabBarController?.navigationItem.title = "Notificações"
        self.tabBarController?.navigationItem.titleView?.tintColor = UIColor(colorLiteralRed: 70/255, green: 97/255, blue: 157/255, alpha: 1)
        
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notificationCell", forIndexPath: indexPath) as! NotificationCell
        
        cell.userPic.image = UIImage(named: "perfil")
        cell.notificationMsg.text = notification[indexPath.row]
        cell.iconNotification.image = UIImage(named: "comentarios") //This will change according with the type of notification
        cell.time.text = "02/02/2002"
        
        return cell
    }
}