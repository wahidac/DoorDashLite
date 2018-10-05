//
//  ExploreViewController.swift
//  DoorDashLite
//
//  Created by Wahid on 10/3/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import UIKit
import CoreLocation

class ExploreViewController: UIViewController, MapViewControllerDelegate {
    var mapViewController: MapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize with the map view controller so we can pick an address
        mapViewController = storyboard!.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapViewController.delegate = self
        //        // Add the child
        //        addChild(mapViewController)
        //        view.addSubview(mapViewControllerView)
        //        mapViewController.didMove(toParent: self)
        //
    }
    
    // TODO: Dont do. on appear we should check if we have shit stored, no? then do this, else, dont.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        mapViewController.modalPresentationStyle = .fullScreen
//        mapViewController.modalTransitionStyle = .coverVertical
//        present(mapViewController, animated: false, completion: nil)
        let initialLocation = CLLocation(latitude: 37.773972, longitude: -122.431297)
        DoorDashAPIController.requestRestaurants(coordinate: initialLocation.coordinate)
    }
    
    func locationSelected(location: CLLocationCoordinate2D) {
        mapViewController.dismiss(animated: true, completion: nil)
        // Start the API Call
    }

    

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
