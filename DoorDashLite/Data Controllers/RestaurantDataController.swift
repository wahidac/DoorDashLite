//
//  RestaurantDataController.swift
//  DoorDashLite
//
//  Created by Wahid on 10/4/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import UIKit
import MapKit

// Fetches restaurants from the API and manages the data source for our
// ExploreViewController to pull from
class RestaurantDataController {
    var delegate: RestaurantDataSourceDelegate?
    var restaurants: [Restaurant] = []
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    func fetchRestaurants(callback: @escaping ([Restaurant]) -> Void) {
        // Fetch the restaurants from API
        APIController.requestRestaurants(coordinate: coordinate) { [weak self] (restaurants) in
            print("API Request returned us \(restaurants.count) restaurants")
            
            self?.restaurants = restaurants
            callback(restaurants)
            
            if let restaurants = self?.restaurants {
                // Fetch all the icons
                for (index, restaurant) in restaurants.enumerated() {
                    APIController.downloadImage(url: restaurant.cover_img_url) { [weak self] (image) in
                        self?.restaurants[index].coverIcon = image
                        self?.delegate?.restaurantUpdated(changeSet: [IndexPath(row: index, section: 0)])
                    }
                }
            }
        }
    }
}
