//
//  LaunchDetailTableViewController.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 7/2/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit
import moa

class LaunchDetailTableViewController: UITableViewController {

    @IBOutlet var launchName: UILabel!
    @IBOutlet var launchDescription: UILabel!
    @IBOutlet var rocketName: UILabel!
    @IBOutlet var agencyName: UILabel!
    @IBOutlet var padName: UILabel!
    @IBOutlet var rocketImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchName.text = launch?.name ?? ""
        launchDescription.text = launch?.missions![0].description ?? ""
        rocketImage.moa.url = launch?.rocket?.imageURL ?? "placeholder"
        rocketName.text = launch?.rocket?.name ?? ""
//        if let agencies = launch?.rocket?.agencies {
//            agencyName.text = agencies[0].name ?? ""
//        }
        
        padName.text = launch?.location?.pads![0].name ?? ""
    }

    var launch: Launch?


}
