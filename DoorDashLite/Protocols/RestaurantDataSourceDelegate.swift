//
//  RestaurantDataSourceDelegate.swift
//  DoorDashLite
//
//  Created by Wahid on 10/4/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation

protocol RestaurantDataSourceDelegate {
    func restaurantsUpdated()
    func restaurantUpdated(restaurant: Restaurant, indexPath: IndexPath)
}
