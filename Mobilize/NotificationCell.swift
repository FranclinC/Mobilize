//
//  NotificationCell.swift
//  Mobilize
//
//  Created by Franclin Cabral on 17/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet var userPic: UIImageView!
    @IBOutlet var notificationMsg: UILabel!
    @IBOutlet var iconNotification: UIImageView!
    @IBOutlet var time: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}