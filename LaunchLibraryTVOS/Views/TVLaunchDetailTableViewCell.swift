//
//  TVLaunchTableViewCell.swift
//  LaunchLibraryTVOS
//
//  Created by petar on 7/7/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit

class TVLaunchDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var launchImageView: UIImageView!
    @IBOutlet weak var launchName: UILabel!
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var netLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
