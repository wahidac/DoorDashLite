//
//  MapViewController.swift
//  DoorDashLite
//
//  Created by Wahid on 10/3/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentAddress: UILabel!
    
    private var currentPosition: MKPointAnnotation!
    var delegate: MapViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 37.773972, longitude: -122.431297)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: false)
        mapView.delegate = self
        
        currentPosition = MKPointAnnotation()
        currentPosition.coordinate = mapView.centerCoordinate
        mapView.addAnnotation(currentPosition)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("I have appeared!")
    }
    
    @IBAction func confirmAddressTapped(_ sender: Any) {
        delegate?.locationSelected(location: mapView.centerCoordinate)
    }    
}

// Pin looks like ass how can we customize? look into viewForAnnotation and returning MKPinAnnotationView
// Will need to maybe do this so user cant touch annotation and fuck w/ the view. make sure you look into
// the reuse identifier
extension MapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        // Update the current position
        currentPosition.coordinate = mapView.centerCoordinate
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // Figure out the address of the current location and update the current address
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: currentPosition.coordinate.latitude, longitude: currentPosition.coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placeMarks: [CLPlacemark]?, error: Error?) in
            guard let first = placeMarks?.first, let address = first.name else {
                // ERROR
                return
            }
            
            // Update the text field
            self?.currentAddress.text = address
            //print(address)
        }
        print("DID CHANGE")
    }
    
}

