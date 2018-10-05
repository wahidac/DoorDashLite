//
//  MapViewControllerDelegate.swift
//  DoorDashLite
//
//  Created by Wahid on 10/3/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import CoreLocation

protocol MapViewControllerDelegate {
    func locationSelected(location: CLLocationCoordinate2D)
}
