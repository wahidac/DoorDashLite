//
//  Restaurant+Presentation.swift
//  DoorDashLite
//
//  Created by Wahid on 11/25/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation

// Human readable strings to use for UI elements
extension Restaurant {
    var costOfDelivery: String {
        let totalNumCents = delivery_fee
        
        guard totalNumCents > 0 else {
            return "Free delivery"
        }
        
        let dollarString = String(totalNumCents / 100)
        let cents = totalNumCents % 100
        let centString = cents < 10 ? "0" + String(cents) : String(cents)
        
        let deliveryFeeDescription = "$" + dollarString + "." + centString + " delivery"
        return deliveryFeeDescription
    }
    
    var timeToDeliver: String {
        return String(asap_time) + " min"
    }
}
