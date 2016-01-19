//
//  MyLikes+CoreDataProperties.swift
//  Mobilize
//
//  Created by Franclin Cabral on 03/12/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MyLikes {
  @NSManaged var user: String?
  @NSManaged var comment: String?
  @NSManaged var flag: Bool
}
