//
//  ProposalDetailedCell.swift
//  Mobilize
//
//  Created by Franclin Cabral on 17/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class ProposalDetailedCell: UITableViewCell {

    @IBOutlet var userPic: UIImageView!
    @IBOutlet var proposedBy: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var proposalText: UILabel!
    @IBOutlet var dateTime: UILabel!
    @IBOutlet var category1: UIImageView!
    @IBOutlet var category2: UIImageView!
    @IBOutlet var viewAgree: UIView!
    @IBOutlet var viewDisagree: UIView!
    @IBOutlet var imageAgree: UIImageView!
    @IBOutlet var agree: UILabel!
    @IBOutlet var agreeCount: UILabel!
    @IBOutlet var imageDisagree: UIImageView!
    @IBOutlet var disagree: UILabel!
    @IBOutlet var disagreeCount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
