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
    static var filter : SingletonDelegate?
    
    
    
    static func change(category: String){
        filter?.changeFilter(category)
    }

    
    
}