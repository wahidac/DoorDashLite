//
//  APIController.swift
//  DoorDashLite
//
//  Created by Wahid on 10/3/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class APIController {
    static let baseURL = URL(string: "https://api.doordash.com")!
    
    static func requestRestaurants(coordinate: CLLocationCoordinate2D, callback: @escaping (([Restaurant]) -> Void)) {
        let restaurantPath = "v1/store_search/"
        let url = baseURL.appendingPathComponent(restaurantPath)
        
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        let latQueryParam = URLQueryItem(name: "lat", value: String(coordinate.latitude))
        let longQueryParam = URLQueryItem(name: "lng", value: String(coordinate.longitude))
        urlComponents.queryItems = [latQueryParam, longQueryParam]
        
        print("Downloading the Restaurant Data for the coordinate: \(coordinate)!")
        let task = URLSession.shared.dataTask(with: urlComponents.url!) {(data, response, error ) in
            // De-serialize the response
            var restaurants: [Restaurant] = []
            if let returnedData = data, let jsonResponse = (try? JSONSerialization.jsonObject(with: returnedData, options: [])) as? [[String: Any]]  {
                restaurants = jsonResponse.compactMap(Restaurant.init)
            } else {
                print("Error de-serializing the API response!")
            }
            
            callback(restaurants)
        }
        
        task.resume()
    }
    
    static func downloadImage(url: URL, callback: @escaping (UIImage?) -> Void) {
        print("Downloading Image from URL: \(url)")
        let task = URLSession.shared.dataTask(with: url) {(data, response, error ) in
            var downloadedImage: UIImage?
            if let returnedData = data, let image = UIImage(data: returnedData) {
                print("Downloaded the Image from URL: \(url)")
                downloadedImage = image
            } else {
                print("Error downloading an image!")
            }
        
            callback(downloadedImage)
        }
        
        task.resume()
    }
}
