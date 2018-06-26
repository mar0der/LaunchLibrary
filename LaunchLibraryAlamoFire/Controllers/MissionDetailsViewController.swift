//
//  MissionDetailsViewController.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/19/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit
import moa

class MissionDetailsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var padLabel: UILabel!
    @IBOutlet weak var tMinusLabel: UILabel!
    @IBOutlet weak var lspNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCountdownLabel()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MissionDetailsViewController.updateCountdownLabel), userInfo: nil, repeats: true)
    }
    
    var launch:Launch?
    
    override func viewWillAppear(_ animated: Bool) {

        
        missionNameLabel.text = launch?.name ?? ""
        rocketNameLabel.text = launch?.missions?[0].description ?? ""
        padLabel.text = launch?.location?.pads?[0].name ?? ""
        detailImageView.moa.url = launch?.rocket?.imageURL ?? "placeholder"
        lspNameLabel.text = launch?.lsp?.name ?? ""
    }

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let fullScreenImageView = UIImageView(image: imageView.image)
        
        fullScreenImageView.frame = UIScreen.main.bounds
        fullScreenImageView.backgroundColor = .black
        fullScreenImageView.contentMode = .scaleAspectFit
        fullScreenImageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(zoomFullScreenImage))
        tapRecognizer.numberOfTapsRequired = 2
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dismissFullScreenImage))
        fullScreenImageView.addGestureRecognizer(tapRecognizer)
        fullScreenImageView.addGestureRecognizer(panRecognizer)
        

        //scrollView.addSubview(fullScreenImageView)
        self.view.addSubview(fullScreenImageView)
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullScreenImage(sender: UIPanGestureRecognizer){
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @objc func zoomFullScreenImage(sender: UITapGestureRecognizer){
        print("zoom")

    }
    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return scrollView.subviews[0]
//    }
//
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "GoToPadWiki":
            let destination = segue.destination as! WebViewController
            destination.receivedURL = (launch?.location?.pads![0])?.wikiURL ?? ""
            destination.searchString = (launch?.location?.pads![0])?.name ?? ""
        case "GoToLSPWiki":
            let destination = segue.destination as! WebViewController
            destination.receivedURL = launch?.lsp?.wikiURL ?? ""
            destination.receivedURL = launch?.lsp?.name ?? ""
        case "GoToMapView":
            let destination = segue.destination as! MapViewController
            destination.latDoubleOpt = launch?.location?.pads?[0].latitude
            destination.longDoubleOpt = launch?.location?.pads?[0].longitude
        default:
            break
        }
    }
    
    //MARK: - custom stuff
    @objc func updateCountdownLabel(){
        self.tMinusLabel?.text = Date.tMinusCounter(to: (self.launch?.net))
    }
    
}
