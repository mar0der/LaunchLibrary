//
//  TVMapViewController.swift
//  LaunchLibraryTVOS
//
//  Created by petar on 7/8/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit
import MapKit

class TVMapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    var latDoubleOpt: Double?
    var longDoubleOpt: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let latDouble = self.latDoubleOpt, let longDouble = self.longDoubleOpt else {return}
        guard let latitude = CLLocationDegrees(exactly: latDouble) else {return}
        guard let longitude = CLLocationDegrees(exactly: longDouble) else {return}
        let location = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(location: location)
    }

    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.mapType = .hybrid
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
