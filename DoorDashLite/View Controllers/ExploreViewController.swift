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
    var restaurantDataSource: RestaurantDataController?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize with the map view controller so we can pick an address
        mapViewController = storyboard!.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        mapViewController.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if restaurantDataSource == nil {
            mapViewController.modalPresentationStyle = .fullScreen
            mapViewController.modalTransitionStyle = .coverVertical
            present(mapViewController, animated: false, completion: nil)
        }
    }
}

extension ExploreViewController: MapViewControllerDelegate {
    func locationSelected(location: CLLocationCoordinate2D) {
        mapViewController.dismiss(animated: true, completion: nil)
        activityIndicator.startAnimating()

        // Fetch the restaurants
        restaurantDataSource = RestaurantDataController(coordinate: location)
        restaurantDataSource?.delegate = self
        restaurantDataSource?.fetchRestaurants(callback: { _ in
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.tableView.reloadData()
            }
        })
    }
}

extension ExploreViewController: RestaurantDataSourceDelegate {
    func restaurantUpdated(changeSet: Set<IndexPath>) {
        DispatchQueue.main.async { [weak self] in
            guard let visibleIndexPaths = self?.tableView.indexPathsForVisibleRows else {
                return
            }
            let visibleSet = Set(visibleIndexPaths)
            let visibleInChangeSet = changeSet.intersection(visibleSet)
            
            self?.tableView.reloadRows(at: Array(visibleInChangeSet), with: .none)
        }
    }
}

extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantDataSource?.restaurants.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath)
            as! RestaurantTableViewCell
        guard let restaurant = restaurantDataSource?.restaurants[indexPath.row] else {
            print("Failed to find restaurant! Configuring an empty cell")
            return cell
        }
        
        // Configure the cell
        cell.name.text = restaurant.name
        cell.restaurantDescription.text = restaurant.description
        cell.costOfDelivery.text = restaurant.costOfDelivery
        cell.timeToDeliver.text = restaurant.timeToDeliver
        cell.icon.image = restaurant.coverIcon

        return cell
    }
}
