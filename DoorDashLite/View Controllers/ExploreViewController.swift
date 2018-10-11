//
//  ExploreViewController.swift
//  DoorDashLite
//
//  Created by Wahid on 10/3/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import UIKit
import CoreLocation

class ExploreViewController: UIViewController {
    var mapViewController: MapViewController!
    var restaurantDataSource: RestaurantDataSource?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize with the map view controller so we can pick an address
        mapViewController = storyboard!.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        //mapViewController.delegate = self

        restaurantDataSource = RestaurantDataSource()
        restaurantDataSource?.delegate = self
        tableView.dataSource = self.restaurantDataSource
    }
    
    // TODO: Dont do. on appear we should check if we have shit stored, no? then do this, else, dont.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        mapViewController.modalPresentationStyle = .fullScreen
//        mapViewController.modalTransitionStyle = .coverVertical
//        present(mapViewController, animated: false, completion: nil)
        let initialLocation = CLLocation(latitude: 37.773972, longitude: -122.431297)
        DoorDashAPIController.requestRestaurants(coordinate: initialLocation.coordinate, cache: restaurantDataSource) { [] (restaurants: [Restaurant]?) in
            let numRestaurants = restaurants?.count ?? 0
            print("API Request returned us \(numRestaurants) restaurants")
        }
    }
    
    func locationSelected(location: CLLocationCoordinate2D) {
        mapViewController.dismiss(animated: true, completion: nil)
        // Start the API Call
        
    }
}

extension ExploreViewController : RestaurantDataSourceDelegate {
    func restaurantUpdated(restaurant: Restaurant, indexPath: IndexPath) {
        if let visibleRows = tableView.indexPathsForVisibleRows, visibleRows.contains(indexPath) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func restaurantsUpdated() {
        // Reload the data
        print("Model updated, reload the table view")
        tableView.reloadData()
    }
}

//
//extension ExploreViewController : MapViewControllerDelegate {
//
//}
