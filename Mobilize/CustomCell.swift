//
//  CustomCell.swift
//  Mobilize
//
//  Created by Franclin Cabral on 19/10/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var proposalBy: UILabel!
    @IBOutlet var nameUser: UILabel!
    @IBOutlet var category1: UIImageView!
    @IBOutlet var category2: UIImageView!
    @IBOutlet var category3: UIImageView!
    @IBOutlet var textProposal: UILabel!
    @IBOutlet var upVote: UIImageView!
    @IBOutlet var upVoteCount: UILabel!
    @IBOutlet var againstVote: UIImageView!
    @IBOutlet var againstVoteCount: UILabel!
    @IBOutlet var comment: UIImageView!
    @IBOutlet var commentCount: UILabel!
    
    var maturation : String!
    var fullProposal : String!
    var time : String!
    var proposalId : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellView.layer.cornerRadius = 6.0
        self.userPicture.layer.cornerRadius = 6.0
        self.upVote.image = UIImage(named: "Feed_Like")
        self.againstVote.image = UIImage(named: "Feed_Dislike")
        self.comment.image = UIImage(named: "Feed_Comment")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
