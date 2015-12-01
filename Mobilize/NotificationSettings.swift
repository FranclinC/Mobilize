//
//  NotificationSettings.swift
//  Mobilize
//
//  Created by Franclin Cabral on 01/12/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class NotificationSettings: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        
        //register nib
        self.tableView.registerNib(UINib(nibName: "NotificationSetting", bundle: nil), forCellReuseIdentifier: "notificationSetting")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notificationSetting", forIndexPath: indexPath) as! NotificationSetting
        if indexPath.section == 0 {
            cell.settingText.text = "Silenciar"
            return cell
        }else if indexPath.section == 1 {
            cell.settingText.text = "Banners"
            return cell
        }else {
            if indexPath.row == 0 {
                cell.settingText.text = "Vibrar"
                return cell
            }else {
                cell.settingText.text = "Sons"
                return cell
            }
            
        }
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 2 {
            return "Mostrar ou ocultar as notificações em banner enquanto você não estiver utilizando o aplicativo."
        }
        return ""
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.min
        }else if section == 2 {
            return CGFloat.min
        }else {
            return 0
        }
    }

}
