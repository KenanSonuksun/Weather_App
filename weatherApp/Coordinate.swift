//
//  Coordinate.swift
//  weatherApp
//
//  Created by Pars arge on 14.07.2021.
//

import Foundation

struct Coordinate {
    let latitude : Double
    let longitude: Double
}

extension Coordinate {
    var description : String {
        return "\(latitude),\(longitude)"
    }
    static var alcatrazIsland : Coordinate {
        return Coordinate(latitude: 37.8267, longitude:-122.4233)
    }
    
}
