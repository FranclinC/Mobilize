//
//  ProposalAgreement.swift
//  Mobilize
//
//  Created by Franclin Cabral on 03/12/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import Foundation
import CoreData

@objc(ProposalAgreement)
class ProposalAgreement: NSManagedObject {
  
  // Insert code here to add functionality to your managed object subclass
  
  func saveFlags (user: String, agree: Bool, disagree: Bool, proposal: String) {
    let moc = DataParameters().managedObjectContext
    let entity = NSEntityDescription.insertNewObjectForEntityForName("ProposalAgreement", inManagedObjectContext: moc) as! ProposalAgreement
    
    entity.setValue(user, forKey: Constants.USER)
    entity.setValue(proposal, forKey: Constants.PROPOSAL)
    entity.setValue(agree, forKey: "agreeFlag")
    entity.setValue(disagree, forKey: "disagreeFlag")
    
    do {
      try moc.save()
      print("Flags saved")
    } catch {
      fatalError("Failure to save context: \(error)")
    }
  }
  
  
  func fetch (user: String, proposal: String) -> [ProposalAgreement] {
    
    var myAgreement : [ProposalAgreement]! = nil
    
    let moc = DataParameters().managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName: "ProposalAgreement")
    fetchRequest.predicate = NSPredicate(format: "user == %@", user)
    fetchRequest.predicate = NSPredicate(format: "proposal == %@", proposal)
    
    do {
      let fetchResults = try moc.executeFetchRequest(fetchRequest) as! [ProposalAgreement]
      
      if fetchResults.count > 0 {
        myAgreement = fetchResults
      }
    }catch {
      fatalError("Could not fetch any value: \(error)")
    }
    return myAgreement
  }
  
}

extension ProposalAgreement {
  
  @NSManaged var proposal: String?
  @NSManaged var user: String?
  @NSManaged var agreeFlag: Bool
  @NSManaged var disagreeFlag: Bool
  
}