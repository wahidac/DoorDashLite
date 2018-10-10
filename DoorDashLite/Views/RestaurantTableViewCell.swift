//
//  RestaurantTableViewCell.swift
//  DoorDashLite
//
//  Created by Wahid on 10/4/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var restaurantDescription: UILabel!
    @IBOutlet weak var costOfDelivery: UILabel!
    @IBOutlet weak var timeToDeliver: UILabel!
    @IBOutlet weak var icon: UIImageView!
}
