//
//  SettingsPicture.swift
//  Mobilize
//
//  Created by Franclin Cabral on 24/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class SettingsPicture: UITableViewCell {

    
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var contributionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userPicture.layer.cornerRadius = 6.0
        self.userPicture.image = UIImage(named: "perfil")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
