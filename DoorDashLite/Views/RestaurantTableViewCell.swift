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
    
    let iconCornerRadius: CGFloat = 5.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Round out the image view and surround it w/ a border
        icon.layer.cornerRadius = iconCornerRadius
        icon.layer.masksToBounds = true
    }
}
