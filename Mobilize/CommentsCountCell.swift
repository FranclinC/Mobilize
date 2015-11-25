//
//  CommentsCountCell.swift
//  Mobilize
//
//  Created by Franclin Cabral on 17/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class CommentsCountCell: UITableViewCell {

    @IBOutlet var imageComment: UIImageView!
    @IBOutlet var commentCount: UILabel!
    @IBOutlet var comment: UILabel!
    
    @IBOutlet var viewCount: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        imageComment.image = UIImage(named: "Proposta_Comment")
        
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.TopRight), cornerRadii: CGSizeMake(10, 10)).CGPath
//        self.viewCount.layer.mask = maskLayer
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
