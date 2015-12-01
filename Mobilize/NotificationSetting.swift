//
//  NotificationSetting.swift
//  Mobilize
//
//  Created by Franclin Cabral on 01/12/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class NotificationSetting: UITableViewCell {


    @IBOutlet var settingText: UILabel!
    @IBOutlet var settingSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
