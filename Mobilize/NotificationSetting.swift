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
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
