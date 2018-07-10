//
//  LaunchRow.swift
//  Launch Library Extension
//
//  Created by petar on 7/11/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit
import WatchKit

class LaunchRowController: NSObject {
    @IBOutlet var rocketName: WKInterfaceLabel!
    
    var launch: Launch? {
        didSet {
            guard let launch = launch else { return }
            rocketName.setText(launch.rocket?.name ?? "")
        }
    }
}
