//
//  SharedValues.swift
//  Mobilize
//
//  Created by Franclin Cabral on 13/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//
//This is the singleton file I created to manage the table view in Propostas classes.
//This is not the better way to do it, it should be implemented with an init function, 
//but due to the amount of code to control the contraints and the time we do have to
//finish this project, thi is the solution



import Foundation

class SharedValues {
    
    static let sharedInstance = SharedValues()
    
    var tableView_singleton : UITableView
    var segmentedControl_singleton : UISegmentedControl
    var themesButton_singleton : UIBarButtonItem
    var newProposal_singleton : UIBarButtonItem
    var tabBar_singleton : UITabBarController
    
    
    private init(){
        
        tableView_singleton = UITableView()
        segmentedControl_singleton = UISegmentedControl()
        themesButton_singleton = UIBarButtonItem()
        newProposal_singleton = UIBarButtonItem()
        tabBar_singleton = UITabBarController()
    }
    
    //This is to set the reference for a table view
    func settableView(tableView: UITableView){
        tableView_singleton = tableView
    }
    
    //This function is to get the reference of the table view
    func gettableView() -> UITableView{
        return tableView_singleton
    }
    
    
    func setSegmentedControl (segmented_control: UISegmentedControl){
        segmentedControl_singleton = segmented_control
    }
    
    func getSegmentedControl () -> UISegmentedControl{
        return segmentedControl_singleton
    }
    
    func setThemesButton (themesButton: UIBarButtonItem){
        themesButton_singleton = themesButton
    }
    
    func getThemesButton () -> UIBarButtonItem{
        return themesButton_singleton
    }
    
    func setNewProposal (newProposal: UIBarButtonItem){
        themesButton_singleton = newProposal
    }
    
    func getNewProposal () -> UIBarButtonItem{
        return newProposal_singleton
    }
    
    func setTabBar (tabBar: UITabBarController){
        tabBar_singleton = tabBar
    }
    func getTabBar () -> UITabBarController{
        return tabBar_singleton
    }
    
    
}