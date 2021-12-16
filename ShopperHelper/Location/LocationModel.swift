//
//  LocationModel.swift
//  ShopperHelper
//
//  Created by Student on 12/8/21.
//

import Foundation
import GooglePlaces

let kLocationNamesKey = "LocationNamesKey"
let kLocationAddressesKey = "LocationAddresesKey"
let kLocationLatitudesKey = "LocationLatitudeKey"
let kLocationLongitudesKey = "LocationLongitudeKey"

class LocationModel : NSObject {
    private var names: [String]
    private var addresses: [String]
    private var latitudes: [Double]
    private var longitudes: [Double]
    private var locations: [Location]
    public static let shared = LocationModel()
    override init(){
        names = []
        addresses = []
        latitudes = []
        longitudes = []
        locations = []
        super.init()
        // Load Locations List
        recoverLocations()
        
        
    }
    func numberOfLocations() -> Int {
        return locations.count
    }
    func addLocation(place: GMSPlace){
        locations.append(Location(place: place))
        names.append(place.name!)
        addresses.append(place.formattedAddress!)
        latitudes.append(place.coordinate.latitude)
        longitudes.append(place.coordinate.longitude)
        updateLocations()
    }
    func removeLocation(at index: Int) {
        if(index < 0 || index >= numberOfLocations()){
            return
        }
        locations.remove(at: index)
        names.remove(at: index)
        addresses.remove(at: index)
        latitudes.remove(at: index)
        longitudes.remove(at: index)
        updateLocations()
    }
    func getLocation(at index: Int) -> Location?{
        if(index < 0 || index >= numberOfLocations()){
            return nil
        }
        return locations[index]
    }
    // For persistent storage
    private func updateLocations(){
        UserDefaults.standard.set(names, forKey: kLocationNamesKey)
        UserDefaults.standard.set(addresses, forKey: kLocationAddressesKey)
        UserDefaults.standard.set(latitudes, forKey: kLocationLatitudesKey)
        UserDefaults.standard.set(longitudes, forKey: kLocationLongitudesKey)
    }
    private func recoverLocations() {
        names = UserDefaults.standard.stringArray(forKey: kLocationNamesKey) ?? []
        addresses = UserDefaults.standard.stringArray(forKey: kLocationAddressesKey) ?? []
        latitudes = UserDefaults.standard.object(forKey: kLocationLatitudesKey) as? [Double] ?? []
        longitudes = UserDefaults.standard.object(forKey: kLocationLongitudesKey) as? [Double] ?? []
        for i in 0..<latitudes.count {
            locations.append(Location(name: names[i], address: addresses[i], latitude: latitudes[i], longitude: longitudes[i]))
        }
    }
}

