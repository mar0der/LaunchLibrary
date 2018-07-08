//
//  TVLaunchDetailsTableViewController.swift
//  LaunchLibraryTVOS
//
//  Created by petar on 7/8/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit

class TVLaunchDetailsTableViewController:
            UITableViewController {

    @IBOutlet var launchName: UILabel!
    @IBOutlet var launchDescription: UILabel!
    @IBOutlet var rocketName: UILabel!
    @IBOutlet var agencyName: UILabel!
    @IBOutlet var padName: UILabel!
    @IBOutlet var rocketImage: UIImageView!
    
    var launch: Launch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchName.text = launch?.name ?? ""
        if let missions = launch?.missions, missions.count > 0 {
            launchDescription.text = missions[0].description ?? "No mission details yet!"
        }
        rocketImage.moa.url = launch?.rocket?.imageURL ?? "placeholder"
        rocketName.text = launch?.rocket?.name ?? ""
        if let missions = launch?.missions, missions.count > 0, let agencies = missions[0].agencies, agencies.count > 0 {
            agencyName.text = agencies[0].name ?? ""
        }
        
        padName.text = launch?.location?.pads![0].name ?? ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
//        case "GoToPadWiki":
//            let destination = segue.destination as! WebViewController
//            destination.receivedURL = (launch?.location?.pads?[0])?.wikiURL ?? ""
//            destination.searchString = (launch?.location?.pads?[0])?.name ?? ""
//        case "GoToLSPWiki":
//            let destination = segue.destination as! WebViewController
//            destination.receivedURL = launch?.lsp?.wikiURL ?? ""
//            destination.receivedURL = launch?.lsp?.name ?? ""
        case "GoToTVMapView":
            let destination = segue.destination as! TVMapViewController
            destination.latDoubleOpt = launch?.location?.pads?[0].latitude
            destination.longDoubleOpt = launch?.location?.pads?[0].longitude
        default:
            break
        }
    }

    
}
