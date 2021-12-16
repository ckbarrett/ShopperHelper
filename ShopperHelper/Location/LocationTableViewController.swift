//
//  SupermarketTableViewController.swift
//  ShopperHelper
//
//  Created by Student on 12/8/21.
//

import UIKit
import CoreLocation

class LocationTableViewController: UITableViewController, CLLocationManagerDelegate {
    let locationModel = LocationModel.shared
    let locationManager = CLLocationManager()
    var currentLong: Double = 0
    var currentLat: Double = 0
    var initializedDistances = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLat = (locValue.latitude)
        currentLong = (locValue.longitude)
        if(!initializedDistances) {
            self.tableView.reloadData()
            initializedDistances = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationModel.numberOfLocations()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationTableCell

        // Configure the cell...
        cell.configure(name: locationModel.getLocation(at: indexPath.row)?.getName() ?? "Unknown Name")
        cell.configure(address: locationModel.getLocation(at: indexPath.row)?.getAddress() ?? "Unknown Address")
        cell.configure(distance: locationModel.getLocation(at: indexPath.row)?.getDistance(lat: currentLat, long: currentLong) ?? 0)
        return cell
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            locationModel.removeLocation(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
