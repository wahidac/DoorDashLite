//
//  DoorDashLiteTests.swift
//  DoorDashLiteTests
//
//  Created by Wahid on 10/3/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import XCTest
@testable import DoorDashLite

class DoorDashLiteTests: XCTestCase {
    func testInitialization() {
        let input: [String: Any] = ["id": 232, "name": "Wendys", "description": "Delicious cheap burgers", "delivery_fee": 8338, "cover_img_url": "https://cdn.doordash.com/media/restaurant/cover/Aloha-BBQ-SF.png", "asap_time": 434]
        
        let restaurant = Restaurant(jsonObject: input)
        
        XCTAssertNotNil(restaurant?.id)
        XCTAssertNotNil(restaurant?.name)
        XCTAssertNotNil(restaurant?.description)
        XCTAssertNotNil(restaurant?.delivery_fee)
        XCTAssertNotNil(restaurant?.cover_img_url)
        XCTAssertNotNil(restaurant?.asap_time)
    }
    
    func testMalformedInitialization() {
        // Missing the "id" property
        let input: [String: Any] = ["name": "Wendys", "description": "Delicious cheap burgers", "delivery_fee": 8338, "cover_img_url": "https://cdn.doordash.com/media/restaurant/cover/Aloha-BBQ-SF.png", "asap_time": 434]
        
        let restaurant = Restaurant(jsonObject: input)
        
        XCTAssertNil(restaurant)
    }
}
