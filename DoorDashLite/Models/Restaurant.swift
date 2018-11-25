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
    let delivery_fee: Int
    let cover_img_url: URL
    let asap_time: Int
    
    init?(jsonObject: [String: Any]) {
        // Required parameters
        guard let id = jsonObject["id"] as? Int, let name = jsonObject["name"] as? String,
            let description = jsonObject["description"] as? String,
            let delivery_fee = jsonObject["delivery_fee"] as? Int,
            let cover_img_url_string = jsonObject["cover_img_url"] as? String,
            let cover_img_url = URL(string: cover_img_url_string),
            let asap_time = jsonObject["asap_time"] as? Int
            else {
                print("Failed to initialize Restaurant")
                return nil
        }
        
        self.id = id
        self.name = name
        self.description = description
        self.delivery_fee = delivery_fee
        self.cover_img_url = cover_img_url
        self.asap_time = asap_time
    }
}
