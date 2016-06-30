//
//  MapCell.swift
//  rePear
//
//  Created by Sara Du on 5/23/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit

class MapCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
