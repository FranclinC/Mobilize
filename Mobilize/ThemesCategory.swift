//
//  ThemesCategory.swift
//  Mobilize
//
//  Created by Franclin Cabral on 10/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class ThemesCategory: UITableViewController {

    var categories = [String]()
    var categoriesEnglish = [String]() //This is just to fix a mistake I made, this can dissapear, remember to talk with the others to decide english or portuguese
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tableView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "categoryCell")


        
        // Do any additional setup after loading the view.
        categories = ["Todos", "Saúde", "Transporte", "Educação", "Segurança", "Cultura"]
        categoriesEnglish = ["All", "Health", "Transport", "Education", "Security", "Culture"]
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().frontViewController.revealViewController().tapGestureRecognizer()
        self.revealViewController().frontViewController.view.userInteractionEnabled = false
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().frontViewController.view.userInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCellTableViewCell
        
        if categories[indexPath.row] == "Saúde"{ //Saúde
            cell.categoryImage.image = UIImage(named: "saude2")
        }else if categories[indexPath.row] == "Transporte" { //Transito
            cell.categoryImage.image = UIImage(named: "mobilidade2")
        }else if categories[indexPath.row] == "Educação" { //Educação
            cell.categoryImage.image = UIImage(named: "educacao2")
        }else if categories[indexPath.row] == "Segurança" { //Segurança
            cell.categoryImage.image = UIImage(named: "seguranca2")
        }else if categories[indexPath.row] == "Cultura" { //Cultura
            cell.categoryImage.image = UIImage(named: "cultura2")
        }else{
            cell.categoryImage.image = UIImage(named: "temas")
        }
        
        cell.categoryName.text = categories[indexPath.row]
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let revealController = self.revealViewController()
        SharedValues.change(categoriesEnglish[indexPath.row])
        revealController.revealToggleAnimated(true)
        
        
        
    }

    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
}
