//
//  LocationTableCell.swift
//  ShopperHelper
//
//  Created by Student on 12/13/21.
//

import UIKit

class LocationTableCell: UITableViewCell {
    @IBOutlet weak var NameText: UILabel!
    @IBOutlet weak var AddressText: UILabel!
    @IBOutlet weak var DistanceText: UILabel!
    
    func configure(name: String){
        NameText.text = name
    }
    func configure(address: String){
        AddressText.text = address
    }
    func configure(distance: Double){
        DistanceText.text = "\(distance)"
    }
}
