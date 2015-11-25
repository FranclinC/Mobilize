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
    //@IBOutlet var viewAgree: UIView!
    //@IBOutlet var viewDisagree: UIView!
    @IBOutlet var imageAgree: UIImageView!
    //@IBOutlet var agree: UILabel!
    @IBOutlet var agreeCount: UILabel!
    @IBOutlet var imageDisagree: UIImageView!
    //@IBOutlet var disagree: UILabel!
    @IBOutlet var disagreeCount: UILabel!
    
    @IBOutlet var viewVote: UIView!
    
    @IBOutlet var agreeButton: UIButton!
    
    @IBOutlet var disagreeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userPic.layer.cornerRadius = 6.0
        
        self.selectionStyle = UITableViewCellSelectionStyle.None

//        let rectShape = CAShapeLayer()
//        rectShape.bounds = self.agreeButton.frame
//        rectShape.position = self.agreeButton.center
//        rectShape.path = UIBezierPath(roundedRect: self.agreeButton.bounds, byRoundingCorners: UIRectCorner.BottomLeft, cornerRadii: CGSize(width: self.agreeButton.frame.width, height: self.agreeButton.frame.height)).CGPath
//        self.agreeButton.layer.mask = rectShape
        
        
        
//        let rectShape = CAShapeLayer()
//        rectShape.bounds = self.viewVote.frame
//        rectShape.position = self.viewVote.center
//        rectShape.path = UIBezierPath(roundedRect: self.viewVote.bounds, byRoundingCorners: .BottomLeft, cornerRadii: CGSize(width: 20, height: 20)).CGPath
//        
//        //self.viewVote.layer.backgroundColor = UIColor.greenColor().CGColor
//        //Here I'm masking the textView's layer with rectShape layer
//        self.viewVote.layer.mask = rectShape
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
