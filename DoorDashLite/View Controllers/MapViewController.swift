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
    
    var currentPosition: MKPointAnnotation!
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
        
        updateCurrentAddress()
    }
    
    @IBAction func confirmAddressTapped(_ sender: Any) {
        print("User selected location at coordinate: \(currentPosition.coordinate)")
        delegate?.locationSelected(location: currentPosition.coordinate)
    }
    
    private func updateCurrentAddress() {
        // Figure out the address of the current location and update the current address
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: currentPosition.coordinate.latitude, longitude: currentPosition.coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placeMarks: [CLPlacemark]?, error: Error?) in
            guard let first = placeMarks?.first, let address = first.name, let currentPosition = self?.currentPosition else {
                print("Failed to reverse locate the address")
                return
            }
            
            // Update the text field
            if location.coordinate.latitude == currentPosition.coordinate.latitude,
                location.coordinate.longitude == currentPosition.coordinate.longitude {
                self?.currentAddress.text = address
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        // Update the current position
        currentPosition.coordinate = mapView.centerCoordinate
        currentAddress.text = "..."
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        updateCurrentAddress()
    }
}
