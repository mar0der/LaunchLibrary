//
//  InterfaceController.swift
//  Launch Library Extension
//
//  Created by petar on 7/10/18.
//  Copyright © 2018 petar. All rights reserved.
//

import WatchKit
import Foundation


class LaunchesController: WKInterfaceController {
    
    @IBOutlet var launchesTable: WKInterfaceTable!
    
    private var isDataBeingUpdated: Bool = false
    private var previousLaunchType: LaunchType = .history
    private var currentLaunchType: LaunchType = .future
    private var previousSort: SortEnum = .desc
    private var currentSort: SortEnum = .asc
    private var defaultLimit: Int = 40
    
    var launches:[Launch] = []
    
    override func awake(withContext context: Any?) {
        //super.awake(withContext: context)
        WebAPI.getLaunches(type: currentLaunchType, limit: defaultLimit, offset: 0, sort: currentSort){ launchesData in
            DispatchQueue.main.async { [unowned self] in
                //                if showSpinner {
                //                    SVProgressHUD.dismiss()
                //                }
                if let launches = launchesData {
                    self.launches += launches
                    self.launchesTable.setNumberOfRows(launches.count, withRowType: "LaunchRow")
                    for index in 0..<self.launchesTable.numberOfRows {
                        guard let controller = self.launchesTable.rowController(at: index) as? LaunchRowController else { continue }
                        
                        controller.launch = launches[index]
                    }
                }else{
                    //FIXME: - put nice alert for unable to fetch data
                }
                //                self.refreshControl?.endRefreshing()
                //                self.isDataBeingUpdated = false
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
