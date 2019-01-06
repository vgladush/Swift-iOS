//
//  ViewController.swift
//  Plan 42
//
//  Created by Yaroslav Zakharchuk on 10/14/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit

enum Location {
    case startLocation
    case destinationLocation
}

enum TransportType {
    case auto
    case walk
}

class ViewController: UIViewController {

    @IBOutlet weak var startLocationTextField: UITextField!
    @IBOutlet weak var endLocationTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var getRouteButton: UIButton!
    @IBOutlet weak var topView: UIView!
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    var transtortSelected = TransportType.auto
    var mainRoute: Bool?
    var startLocationCoordinate = CLLocation()
    var endLocationCoordinate = CLLocation()
    var annotationArray = [CustomPin]()
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.isHidden = true
        initLocationManager()
        initStyle()
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        mapView.userTrackingMode = .follow
    }
    
    func initStyle() {
        topView.backgroundColor = UIColor(red:0.77, green:0.79, blue:0.91, alpha:0.5)
        getRouteButton.layer.backgroundColor = UIColor(red:0.47, green:0.53, blue:0.80, alpha:1.0).cgColor
        getRouteButton.layer.cornerRadius = 5
    }

    @IBAction func showSearchView(_ sender: UIBarButtonItem) {
        if topView.isHidden {
            topView.isHidden = false
        } else {
            topView.isHidden = true
        }
    }
    
    @IBAction func startPoint(_ sender: UITextField) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        locationSelected = .startLocation
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @IBAction func endPoint(_ sender: UITextField) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        locationSelected = .destinationLocation
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @IBAction func changeTypeMap(_ sender: UISegmentedControl) {
        switch sender.titleForSegment(at: sender.selectedSegmentIndex)! {
        case "Standard":
            mapView.mapType = MKMapType.standard;
        case "Satellite":
            mapView.mapType = MKMapType.satellite;
        case "Hybrid":
            mapView.mapType = MKMapType.hybrid;
        default:
            break
        }
    }
    
    @IBAction func transportType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            transtortSelected = TransportType.auto
        case 1:
            transtortSelected = TransportType.walk
        default:
            break
        }
    }
    
    @IBAction func currentLocation(_ sender: UIButton) {
        if let currentCoor = currentCoordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let location = CLLocationCoordinate2DMake((currentCoor.latitude), (currentCoor.longitude))
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func setCurrentLocation(_ sender: UIButton) {
        if let currentLocation = currentCoordinate {
            startLocationTextField.text = "My location"
            startLocationCoordinate = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        }
    }
    
    @IBAction func createRoute(_ sender: UIButton) {
        topView.isHidden = true
        if !(startLocationTextField.text?.isEmpty)! && !(endLocationTextField.text?.isEmpty)! {
            self.mapView.removeAnnotations(annotationArray)
            self.mapView.removeOverlays(mapView.overlays)
            annotationArray.removeAll()
            let sourceLocation = CLLocationCoordinate2D(latitude: startLocationCoordinate.coordinate.latitude,
                                                        longitude: startLocationCoordinate.coordinate.longitude)
            let destinationLocation = CLLocationCoordinate2D(latitude: endLocationCoordinate.coordinate.latitude,
                                                             longitude: endLocationCoordinate.coordinate.longitude)
            
            self.annotationArray.append(CustomPin(pinTitle: "Start Location", pinSubTitle: "\(String(describing: startLocationTextField.text!))", location: sourceLocation))
            self.annotationArray.append(CustomPin(pinTitle: "Destination Location", pinSubTitle: "\(String(describing: endLocationTextField.text!))", location: destinationLocation))
            
            self.mapView.addAnnotations(annotationArray)
            
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
            directionRequest.requestsAlternateRoutes = true
            if transtortSelected == .auto {
                directionRequest.transportType = .automobile
            } else {
                directionRequest.transportType = .walking
            }
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (response, error) in
                guard let directionResponse = response else {
                    if let error = error {
                        print("Error geting directions \(error.localizedDescription)")
                    }
                    return
                }
                print(directionResponse.routes.count)
                for (index, route) in directionResponse.routes.enumerated() {
                    self.mainRoute = index == 0 ? true : false
                    self.mapView.add(route.polyline, level: .aboveRoads)
                    let rect = route.polyline.boundingMapRect
                    self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                }
            }
        } else {
            let alertController = UIAlertController.init(title: nil, message: "Set the end point of the route", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        if self.mainRoute! {
            renderer.strokeColor = UIColor(red:0.47, green:0.53, blue:0.80, alpha:1.0)
            renderer.lineWidth = 5
        } else {
            renderer.strokeColor = UIColor(red:CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
                                           green:CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
                                           blue:CGFloat(Float(arc4random()) / Float(UINT32_MAX)), alpha:1.0)
            renderer.lineWidth = 2
        }
        return renderer
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentCoordinate = manager.location!.coordinate
    }
}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        if locationSelected == .startLocation {
            startLocationTextField.text = "\(String(describing: place.formattedAddress!))"
            startLocationCoordinate = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        } else {
            endLocationTextField.text = "\(String(describing: place.formattedAddress!))"
            endLocationCoordinate = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
        self.dismiss(animated: true, completion: nil)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

public extension UISearchBar {
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}

