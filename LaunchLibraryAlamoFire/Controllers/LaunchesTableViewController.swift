//
//  LaunchesTableViewController.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/19/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit
import SVProgressHUD


class LaunchesTableViewController: UITableViewController {
    
    
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
    
    @IBAction func refreshData(_ sender: UIRefreshControl) {
        pullMoreData(type: currentLaunchType, limit: defaultLimit, offset: 0, sort: currentSort, showSpinner: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 140
        //we start with fature lauches
        sortButton.isEnabled = false
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
                self.refreshControl?.endRefreshing()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchTableViewCell
        let launch = self.launches[indexPath.row]
        //FIXME: put this in extension of Date
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        
        cell.launchName?.text = launch.name ?? ""
        cell.rocketName?.text = launch.lsp?.name ?? ""
        cell.launchImageView.moa.url = launch.rocket?.imageURL ?? "placeholder"
        if let net = launch.net {
           cell.netLabel?.text = dateFormatterGet.string(from: net)
        }
    
        //print(indexPath.row.description + " of " + launches.count.description)
        //FIXME: - extract number 10 to configuration file
        if indexPath.row > launches.count - 10 && isDataBeingUpdated == false {
            isDataBeingUpdated = true
            previousLaunchType = currentLaunchType
            pullMoreData(type: currentLaunchType, limit: 50, offset: launches.count, sort: currentSort, showSpinner: false)
        }
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "GoToLaunchDetails":
            let launch = self.launches[tableView.indexPathForSelectedRow!.row]
            let destination = segue.destination as! MissionDetailsViewController
            destination.launch = launch
            
        case "GoToLaunchDetailsTable":
            let launch = self.launches[tableView.indexPathForSelectedRow!.row]
            let destination = segue.destination as! LaunchDetailTableViewController
            destination.launch = launch
        default:
            break
            
        }
    }
}

//https://youtu.be/Sm3jupdLJBY?t=36m15s row height for table view
