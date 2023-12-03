//
//  Utils.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/28/23.
//

import Foundation

class Utils {
    static func formatIntToDollars(number: Int) -> String {
        var stringDollars = String(number)
        let index = stringDollars.index(stringDollars.endIndex, offsetBy: -2)
        stringDollars.insert(".", at: index)
        stringDollars = "$" + stringDollars
        return stringDollars
    }
    static func distanceLatLong(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let r = 6371.0; // km
      let p = Double.pi / 180;

      let a = 0.5 - cos((lat2 - lat1) * p) / 2
                    + cos(lat1 * p) * cos(lat2 * p) *
                      (1 - cos((lon2 - lon1) * p)) / 2;

        return 2.0 * r * asin(sqrt(a));
    }
}
