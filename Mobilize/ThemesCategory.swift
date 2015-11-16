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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tableView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "categoryCell")


        
        // Do any additional setup after loading the view.
        categories = ["Todos", "Saúde", "Trânsito", "Educação", "Segurança", "Cultura"]
        
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
        }else if categories[indexPath.row] == "Trânsito" { //Transito
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
        
        //This is to come back to the previous view controller
        let revealController = self.revealViewController()
        var frontController : UIViewController? = nil
        var previousView : Propostas = Propostas()
        
        
        //Need to find a way to pass a value without performing a segue. Maybe Singleton??
        frontController = Propostas()
        revealController.revealToggleAnimated(true)
        
        //This is not implemented yet
        //revealController.pushFrontViewController(frontController, animated: false)
        
        
        
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVc = segue.destinationViewController as! Propostas
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        
        //here i need the value of the parameter for the search
        destVc.category = categories[indexPath.row] //Get the value of the category

    }
    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
}
