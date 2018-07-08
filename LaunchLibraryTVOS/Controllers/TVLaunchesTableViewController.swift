//
//  TVLaunchesTableViewController.swift
//  LaunchLibraryTVOS
//
//  Created by petar on 7/7/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import moa

class TVLaunchesTableViewController: UITableViewController {

    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    var launches:[Launch] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    private var isDataBeingUpdated: Bool = false
    private var previousLaunchType: LaunchType = .history
    private var currentLaunchType: LaunchType = .future
    private var previousSort: SortEnum = .desc
    private var currentSort: SortEnum = .asc
    private var defaultLimit: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pullMoreData(type: currentLaunchType, limit: defaultLimit, offset: 0, sort: .asc, showSpinner: true)
    }
    
    @IBAction func launchTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentLaunchType = .history
            previousLaunchType = .future
            currentSort = .desc
            previousSort = .asc
            sortButton.isEnabled = true
        case 1:
            currentLaunchType = .future
            previousLaunchType = .history
            currentSort = .asc
            previousSort = .desc
            sortButton.isEnabled = false
        default:
            break
        }
        launches = []
        pullMoreData(type: currentLaunchType, limit: defaultLimit, offset: 0, sort: currentSort, showSpinner: true)
    }
    
    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        if previousSort == .asc {
            currentSort = .asc
            previousSort = .desc
            self.sortButton?.title = "sort⇣"
        }else{
            currentSort = .desc
            previousSort = .asc
            self.sortButton?.title = "sort⇡"
        }
        launches = []
        pullMoreData(type: currentLaunchType, limit: defaultLimit, offset: 0, sort: currentSort, showSpinner: true)
    }

    private func pullMoreData(type: LaunchType, limit:Int, offset:Int, sort: SortEnum, showSpinner: Bool){
        if showSpinner  { SVProgressHUD.show()}
        WebAPI.getLaunches(type: type, limit: limit, offset: offset, sort: sort){ launchesData in
            DispatchQueue.main.async { [unowned self] in
                if showSpinner {
                    SVProgressHUD.dismiss()
                }
                if let launches = launchesData {
                    self.launches += launches
                }else{
                    //FIXME: - put nice alert for unable to fetch data
                }
               // self.refreshControl?.endRefreshing()
               self.isDataBeingUpdated = false
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVLaunchCell", for: indexPath) as! TVLaunchDetailTableViewCell
        let launch = self.launches[indexPath.row]
        
        cell.launchName?.text = launch.name ?? ""
        cell.rocketName?.text = launch.lsp?.name ?? ""
        cell.launchImageView.moa.url = launch.rocket?.imageURL ?? "placeholder"
        if let net = launch.net {
            cell.netLabel?.text = Date.llDateToString(net)
        }
        
        //print(indexPath.row.description + " of " + launches.count.description)
        if indexPath.row > launches.count - Config.loadMoreBuffer && isDataBeingUpdated == false {
            isDataBeingUpdated = true
            previousLaunchType = currentLaunchType
            pullMoreData(type: currentLaunchType, limit: Config.pullMoreLimit, offset: launches.count, sort: currentSort, showSpinner: false)
        }

        return cell
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case "GoToTVLaunchDetailsTable":
            let launch = self.launches[tableView.indexPathForSelectedRow!.row]
            let destination = segue.destination as! TVLaunchDetailsTableViewController
            destination.launch = launch
        default:
            break
            
        }
    }
}
