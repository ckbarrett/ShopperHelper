//
//  Location.swift
//  ShopperHelper
//
//  Created by Student on 12/9/21.
//

import Foundation
import CoreLocation
import GooglePlaces

struct Location {
    private var name: String
    private var address: String
    private var latitude: Double
    private var longitude: Double
    init(place: GMSPlace){
        name = place.name ?? "Name Unkown"
        address = place.formattedAddress ?? "Address Unknown"
        latitude = place.coordinate.latitude
        longitude = place.coordinate.longitude
    }
    init(name: String, address: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    public func getName() -> String {
        return name
    }
    public func getAddress() -> String {
        return address
    }
    public func getLatitude() -> Double {
        return latitude
    }
    public func getLongitude() -> Double {
        return longitude
    }
    public func getDistance(lat: Double, long: Double) -> Double {
        // Calculate distance
        let myLocation = CLLocation(latitude: lat, longitude: long) // current location
        let storeLocation = CLLocation(latitude: latitude, longitude: longitude)
        let distanceInMeters = myLocation.distance(from: storeLocation)
        let distanceInMiles = distanceInMeters / 1609.34
        // Round to 2 decimal places
        return Double(Int(distanceInMiles * 100))/Double(100)
    }
}
