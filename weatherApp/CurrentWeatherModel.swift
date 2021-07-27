//
//  CurrentWeatherModel.swift
//  weatherApp
//
//  Created by Pars arge on 14.07.2021.
//

import Foundation
import UIKit

struct CurrentWeatherModel {
    let temperature : String
    let icon : UIImage
    let rain : String
    let humitity : String
    let summary : String
    
    init(data : CurrentWeather){
        self.summary = data.summary
        self.icon = data.iconImage
        self.temperature = "\(Int(data.temperature))°"
        self.rain = "%\(data.rain * 100)"
        self.humitity = "%\(Int(data.humitity * 100))"
    }
}
