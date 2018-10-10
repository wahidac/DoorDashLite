//
//  RestaurantDataSource.swift
//  DoorDashLite
//
//  Created by Wahid on 10/4/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import UIKit

class RestaurantDataSource: NSObject, UITableViewDataSource {
    var delegate: RestaurantDataSourceDelegate?
    
    var restaurants: [Restaurant]? {
        didSet {
            delegate?.restaurantsUpdated()
            for restaurant in restaurants! {
                DoorDashAPIController.downloadImage(url: restaurant.cover_img_url) { [weak self] in
                    self?.restaurantIcons[restaurant.id] = $0
                }
            }
        }
    }
    // Key: Restaurants unique id, Value: UIImage
    var restaurantIcons: [Int: UIImage] = [:]
    var cellsThatNeedIcons: [Int: UITableViewCell] = [:]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let restaurants = self.restaurants else {
            return 0
        }
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let row = indexPath.row
       // return restaurants[row]
        guard let restaurants = self.restaurants else {
            print("Failed to find data source, could not configure cell")
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath)
            as! RestaurantTableViewCell
        let restaurant = restaurants[indexPath.row]
        
        // Configure the cell
        cell.name.text = restaurant.name
        cell.restaurantDescription.text = restaurant.description
        cell.costOfDelivery.text = restaurant.delivery_fee
        cell.timeToDeliver.text = restaurant.asap_time

        if let cachedImage = restaurantIcons[restaurant.id] {
            cell.icon.image = cachedImage
            cellsThatNeedIcons[restaurant.id] = nil
        }

        return cell
    }
}
