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

    
    @IBOutlet var proposalBy: UILabel! //Thinking that it might change in other languages
    @IBOutlet var nameUser: UILabel!
    
    @IBOutlet var category1: UIImageView!
    @IBOutlet var category2: UIImageView!
    @IBOutlet var category3: UIImageView!
    
    @IBOutlet var textProposal: UILabel!
    
    @IBOutlet var upVote: UIImageView! //It is good let it like that because it can change the icon programatically
    @IBOutlet var upVoteCount: UILabel!
    
    @IBOutlet var againstVote: UIImageView! //It is good let it like that because it can change the icon programatically. I couldn't find a better name
    @IBOutlet var againstVoteCount: UILabel!
    
    
    @IBOutlet var comment: UIImageView! //It is good let it like that because it can change the icon programatically
    @IBOutlet var commentCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.layer.cornerRadius = 5.0
        self.cellView.layer.cornerRadius = 6.0
        self.userPicture.layer.cornerRadius = 6.0

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
