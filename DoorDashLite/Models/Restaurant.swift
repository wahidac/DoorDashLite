//
//  Restaurant.swift
//  DoorDashLite
//
//  Created by Wahid on 10/4/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation

// TODO: Test this by initializing it with good + bad json
// Test1: the Dollar formatting logic, pass in various and make sure it works
struct Restaurant {
    var id: Int
    let name: String
    let description: String
    let delivery_fee: String
    let cover_img_url: URL
    let asap_time: String
    
    init?(jsonObject: [String: Any]) {
        // Required parameters
        guard let id = jsonObject["id"] as? Int, let description = jsonObject["description"] as? String,
              let name = jsonObject["name"] as? String, let cover_img_url_string = jsonObject["cover_img_url"] as? String,
              let cover_img_url = URL(string: cover_img_url_string), let delivery_fee_cents = jsonObject["delivery_fee"] as? Int,
              let asap_time = jsonObject["asap_time"] as? Int
        else {
            print("Failed to initialize Restaurant")
            return nil
        }
        
        self.id = id
        self.description = description
        self.name = name
        self.cover_img_url = cover_img_url
        
        var deliveryFeeDescription = "$"
        let dollarString = String(delivery_fee_cents / 100)
        let cents = delivery_fee_cents % 100
        let centString = cents < 10 ? "0" + String(cents) : String(cents)
        
        deliveryFeeDescription += dollarString + "." + centString
        self.delivery_fee = deliveryFeeDescription
        self.asap_time = String(asap_time)
    }
}
