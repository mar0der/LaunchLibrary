//
//  CustomTableViewCell.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit
import moa

class LaunchTableViewCell: UITableViewCell {

    @IBOutlet weak var launchImageView: UIImageView!
    @IBOutlet weak var launchName: UILabel!
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var netLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
