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
    @IBOutlet var imageAgree: UIImageView!
    @IBOutlet var agreeCount: UILabel!
    @IBOutlet var imageDisagree: UIImageView!
    @IBOutlet var disagreeCount: UILabel!
    @IBOutlet var viewVote: UIView!
    @IBOutlet var agreeButton: UIButton!
    @IBOutlet var disagreeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.userPic.layer.cornerRadius = 6.0
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
