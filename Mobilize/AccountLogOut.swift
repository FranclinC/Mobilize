//
//  AccountLogOut.swift
//  Mobilize
//
//  Created by Franclin Cabral on 27/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse

class AccountLogOut: UITableViewCell {

    @IBOutlet var logOutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.logOutButton = UIButton()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func logOut(sender: AnyObject) {
        print("To saindo dessa porra")
        PFUser.logOut()
        
    }

}
