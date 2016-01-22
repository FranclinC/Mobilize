//
//  CommentCell.swift
//  Mobilize
//
//  Created by Franclin Cabral on 17/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet var userPic: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var commentTime: UILabel!
    @IBOutlet var commentText: UILabel!
    //@IBOutlet var starImage: UIImageView!
    //@IBOutlet var starCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userPic.layer.cornerRadius = 6.0
        self.commentText.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
