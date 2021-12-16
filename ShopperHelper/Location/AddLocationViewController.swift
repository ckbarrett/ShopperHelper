//
//  AddLocationViewController.swift
//  ShopperHelper
//
//  Created by Student on 12/13/21.
//

import UIKit
import GooglePlaces

class AddLocationViewController: GMSAutocompleteViewController, GMSAutocompleteViewControllerDelegate {
    let locationModel = LocationModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup
        self.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.openingHours.rawValue) |
                                                    UInt(GMSPlaceField.coordinate.rawValue) |
                                                    UInt(GMSPlaceField.formattedAddress.rawValue))
        self.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        self.autocompleteFilter = filter
    }
    // Handle user selection
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        locationModel.addLocation(place: place)
        dismiss(animated: true, completion: nil)
    }
    // Error received during operation
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
        dismiss(animated: true, completion: nil)
    }
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

}
