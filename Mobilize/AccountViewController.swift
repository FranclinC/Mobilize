//
//  AccountViewController.swift
//  Mobilize
//
//  Created by Franclin Cabral on 27/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var logOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        //register nib
        self.tableView.registerNib(UINib(nibName: "AccountCell", bundle: nil), forCellReuseIdentifier: "accountCell")
        //register nib
        self.tableView.registerNib(UINib(nibName: "AccountLogOut", bundle: nil), forCellReuseIdentifier: "accountLogOut")
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        var doneButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "saveConfiguration")
        self.navigationItem.rightBarButtonItem = doneButton
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
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! AccountCell
            cell.textCell.placeholder = "Nome do Perfil"
            
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! AccountCell
            cell.textCell.placeholder = "Senha atual"
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! AccountCell
            cell.textCell.placeholder = "Nova Senha"
            
            return cell
        }
        
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
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Senha".capitalizedString
        }else{
            return ""
        }
    }
    
    func saveConfiguration (){
        print("Done button")
    }
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logOut", sender: nil)
    }
    
}
