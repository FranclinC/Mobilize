//
//  AccountViewController.swift
//  Mobilize
//
//  Created by Franclin Cabral on 27/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var logOutButton: UIButton!
    
    var user : PFUser!
    var isLinkedWithFacebook : Bool = Bool()
    
    var userName : String?
    var currentPassword : String?
    var newPassword : String?
    var confirmPassword : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = PFUser.currentUser()
        isLinkedWithFacebook = PFFacebookUtils.isLinkedWithUser(user)
        tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "AccountCell", bundle: nil), forCellReuseIdentifier: "accountCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let doneButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "saveConfiguration")
        self.navigationItem.rightBarButtonItem = doneButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{
            return 1
        }else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! AccountCell
            cell.textCell.placeholder = self.user["name"] as? String
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! AccountCell
            cell.textCell.placeholder = "Senha atual"
            cell.textCell.secureTextEntry = true
            if self.isLinkedWithFacebook {
                cell.textCell.userInteractionEnabled = false
            }
            return cell
        }else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! AccountCell
                cell.textCell.placeholder = "Nova Senha"
                cell.textCell.secureTextEntry = true
                
                if self.isLinkedWithFacebook {
                    cell.textCell.userInteractionEnabled = false
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath) as! AccountCell
                cell.textCell.placeholder = "Confirmar Senha"
                cell.textCell.secureTextEntry = true
                if self.isLinkedWithFacebook {
                    cell.textCell.userInteractionEnabled = false
                }
                
                return cell
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0  || section == 2 {
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
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            if self.isLinkedWithFacebook {
                return "Atualmente você está logado com o facebook. Sua senha está criptografada pelo facebook"
            }
        }
        return ""
    }
    
    func saveConfiguration() {
        var array = self.tableView.indexPathsForVisibleRows

        let cellNome : AccountCell? = self.tableView.cellForRowAtIndexPath(array![0]) as? AccountCell
        let cellCurrentPassword : AccountCell? = self.tableView.cellForRowAtIndexPath(array![1]) as? AccountCell
        let cellNewPassword : AccountCell? = self.tableView.cellForRowAtIndexPath(array![2]) as? AccountCell
        let cellConfirm : AccountCell? = self.tableView.cellForRowAtIndexPath(array![3]) as? AccountCell

        var didChange = false
        
        if cellNome?.textCell.text != "" {
            user.setValue(cellNome?.textCell.text, forKey: "name")
            print("Mudei essa porra")
            didChange = true
        }
        
        if !self.isLinkedWithFacebook {
            if cellCurrentPassword != "" {
                if cellNewPassword?.textCell.text == cellConfirm?.textCell.text {
                    self.user.setValue(cellNewPassword?.textCell.text, forKey: "password")
                    didChange = true
                }else{
                    //Show alert
                    let alertError = UIAlertController(title: "Erro", message: "Confirmar senha não confere com nova senha", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    
                    alertError.addAction(okAction)
                    self.presentViewController(alertError, animated: true, completion: nil)
                }
            }
        }
        
        if didChange {
            self.user.saveEventually()
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logOut", sender: nil)
    }
}
