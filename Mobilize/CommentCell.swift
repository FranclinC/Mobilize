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
    @IBOutlet var commentText: UITextView!
    @IBOutlet var starImage: UIImageView! //This is because the image is one star
    @IBOutlet var starCount: UILabel! //That is how many "likes" the proposal had
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
