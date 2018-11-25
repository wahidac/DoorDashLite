//
//  Restaurant+PresentationTests.swift
//  DoorDashLiteTests
//
//  Created by Wahid on 11/25/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import XCTest

class Restaurant_PresentationTests: XCTestCase {
    func testFreeDelivery() {
        let input: [String: Any] = ["id": 23232, "name": "Wendys", "description": "Delicious cheap burgers", "delivery_fee": 0, "cover_img_url": "https://cdn.doordash.com/media/restaurant/cover/Aloha-BBQ-SF.png", "asap_time": 434]
        let expectedCost = "Free delivery"
        
        let restaurant = Restaurant(jsonObject: input)
        
        XCTAssertEqual(expectedCost, restaurant?.costOfDelivery)
    }
    
    func testDeliveryCostForMoreThanOneDollar() {
        let input: [String: Any] = ["id": 23232, "name": "Wendys", "description": "Delicious cheap burgers", "delivery_fee": 219, "cover_img_url": "https://cdn.doordash.com/media/restaurant/cover/Aloha-BBQ-SF.png", "asap_time": 434]
        let expectedCost = "$2.19 delivery"
        
        let restaurant = Restaurant(jsonObject: input)
        
        XCTAssertEqual(expectedCost, restaurant?.costOfDelivery)
    }
    
    func testDeliveryCostForLessThanOneDollar() {
        let input: [String: Any] = ["id": 23232, "name": "Wendys", "description": "Delicious cheap burgers", "delivery_fee": 83, "cover_img_url": "https://cdn.doordash.com/media/restaurant/cover/Aloha-BBQ-SF.png", "asap_time": 434]
        let expectedCost = "$0.83 delivery"
        
        let restaurant = Restaurant(jsonObject: input)
        
        XCTAssertEqual(expectedCost, restaurant?.costOfDelivery)
    }
    
    func testTimeToDeliver() {
        let input: [String: Any] = ["id": 23232, "name": "Wendys", "description": "Delicious cheap burgers", "delivery_fee": 83, "cover_img_url": "https://cdn.doordash.com/media/restaurant/cover/Aloha-BBQ-SF.png", "asap_time": 37]
        let expectedTime = "37 min"
        
        let restaurant = Restaurant(jsonObject: input)
        
        XCTAssertEqual(expectedTime, restaurant?.timeToDeliver)
    }
}
