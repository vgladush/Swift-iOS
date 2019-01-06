//
//  SecondViewController.swift
//  d05
//
//  Created by Vyacheslav GLADUSH on 08.10.2018.
//  Copyright © 2018 Vyacheslav GLADUSH. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter =  10
        locationManager.startUpdatingLocation()
    }

    @IBAction func segControl(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            mapView.mapType = .standard
        }
        else if (sender.selectedSegmentIndex == 1) {
            mapView.mapType = .satellite
        }
        else {
            mapView.mapType = .hybrid
        }
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        let coordinates = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
