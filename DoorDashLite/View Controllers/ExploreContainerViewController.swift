//
//  ExploreContainerViewController.swift
//  DoorDashLite
//
//  Created by Wahid on 10/3/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

// A container view controller to manage the MapViewController and ExploreTableViewController

import UIKit

class ExploreContainerViewController: UIViewController {
    var mapViewController: MapViewController!
    // TODO: this is optional right? We don't always have one. Map is always here though, shouldnt change
    var exploreTableViewController: ExploreTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize with the map view controller so we can pick an address
        guard let mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController"), let mapViewControllerView = mapViewController.view else {
            print("Could not instantiate Map View Controller")
            return
        }
        
        // Add the child
        addChild(mapViewController)
        view.addSubview(mapViewControllerView)
        mapViewController.didMove(toParent: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
