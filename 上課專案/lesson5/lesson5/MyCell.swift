//
//  MyCell.swift
//  lesson5
//
//  Created by Robert on 2019/4/29.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var urlLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
