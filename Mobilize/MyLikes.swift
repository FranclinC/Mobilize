//
//  MyLikes.swift
//  Mobilize
//
//  Created by Franclin Cabral on 03/12/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import Foundation
import CoreData

@objc(MyLikes)
class MyLikes: NSManagedObject {
}

extension MyLikes {
  @NSManaged var user: String?
  @NSManaged var comment: String?
  @NSManaged var flag: Bool
}