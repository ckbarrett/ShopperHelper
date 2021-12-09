//
//  GroceryModel.swift
//  ShopperHelper
//
//  Created by Student on 12/8/21.
//

import Foundation

let kGroceriesKey = "GroceriesKey"

class GroceryModel : NSObject {
    private var groceries: [String]
    public static let shared = GroceryModel()
    override init(){
        groceries = []
        // Load Grocery List
        if let storedGroceries =
        UserDefaults.standard.object(forKey: kGroceriesKey) as? [String]{
            groceries = storedGroceries
        }
        // Set a default grocery list if unable to restore old one
        else{
            groceries.append("Example Item")
        }
        
        super.init()
    }
    func numberOfGroceries() -> Int {
        return groceries.count
    }
    func addGrocery(_ name: String){
        groceries.append(name)
        updateGroceries()
    }
    func removeGrocery(at index: Int) {
        if(index < 0 || index >= numberOfGroceries()){
            return
        }
        groceries.remove(at: index)
        updateGroceries()
    }
    func getGrocery(at index: Int) -> String?{
        if(index < 0 || index >= numberOfGroceries()){
            return nil
        }
        return groceries[index]
    }
    // For persistent storage
    func updateGroceries(){
        UserDefaults.standard.set(groceries, forKey: kGroceriesKey)
    }
}

