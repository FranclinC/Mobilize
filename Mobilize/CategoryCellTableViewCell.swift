//
//  CategoryCellTableViewCell.swift
//  Mobilize
//
//  Created by Franclin Cabral on 10/11/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class CategoryCellTableViewCell: UITableViewCell {

    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
