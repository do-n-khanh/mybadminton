//
//  DiscoveryCell.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/08/17.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class DiscoveryCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var courtNumLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
