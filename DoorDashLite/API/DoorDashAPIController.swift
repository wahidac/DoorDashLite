//
//  DoorDashAPIController.swift
//  DoorDashLite
//
//  Created by Wahid on 10/3/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import CoreLocation

class DoorDashAPIController {
    
    static let baseURL = URL(string: "https://api.doordash.com")!
    
    // As params we need a callback + a persistence mechanism as well
    // TODO: make testable if time
    static func requestRestaurants(coordinate: CLLocationCoordinate2D) {
        let restaurantPath = "v1/store_search/"
        let url = baseURL.appendingPathComponent(restaurantPath)
        
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        let latQueryParam = URLQueryItem(name: "lat", value: String(coordinate.latitude))
        let longQueryParam = URLQueryItem(name: "lng", value: String(coordinate.longitude))
        urlComponents.queryItems = [latQueryParam, longQueryParam]
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) {(data, response, error ) in
            // De-serialize the response
            guard let returnedData = data, let jsonResponse = (try? JSONSerialization.jsonObject(with: returnedData, options: [])) as? [[String: Any]] else {
                print("Error de-serializing the API response!")
                return
            }

            let restaurants = jsonResponse.compactMap(Restaurant.init)
            for restaurant in restaurants {
                 print(restaurant)
            }
          //  print(error)
            // Send the results t
        }
        
        task.resume()
    }
    
}
