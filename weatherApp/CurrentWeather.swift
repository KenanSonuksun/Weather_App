//
//  CurrentWeather.swift
//  weatherApp
//
//  Created by Pars arge on 14.07.2021.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature : Double
    let rain : Double
    let humitity : Double
    let icon : String
    let summary : String
    
    init(temperature : Double,rain : Double,hubitity : Double,icon:String,summary:String) {
        self.temperature = temperature
        self.rain = rain
        self.humitity = hubitity
        self.icon = icon
        self.summary = summary
    }
}

extension CurrentWeather {
    
    var iconImage : UIImage {
        
        switch icon {
        case "clear-day" : return #imageLiteral(resourceName: "clear-day")
        case "clear-night" : return #imageLiteral(resourceName: "clear-night")
        case "rain" : return #imageLiteral(resourceName: "rain")
        case "snow" : return #imageLiteral(resourceName: "snow")
        case "sleet" : return #imageLiteral(resourceName: "sleet")
        case "wing" : return #imageLiteral(resourceName: "wind")
        case "fog" : return #imageLiteral(resourceName: "fog")
        case "cloudy" : return #imageLiteral(resourceName: "cloudy")
        case "partly-cloudy-day" : return #imageLiteral(resourceName: "partly-cloudy-day")
        case "partly-cloudy-night" : return #imageLiteral(resourceName: "partly-cloudy-night")
        default:return #imageLiteral(resourceName: "default")
        }
    }
}


extension CurrentWeather {
    
    struct Key {
        static let temperature = "temperature"
        static let icon = "icon"
        static let summary = "summary"
        static let humidity = "humidity"
        static let rain = "precipProbability"
    }
    
    init?(json:[String : AnyObject]) {
       guard let temp = json[Key.temperature] as? Double,
             let iconStr = json[Key.icon] as? String,
             let sum = json[Key.summary] as? String,
             let hum = json[Key.humidity] as? Double,
             let rain = json[Key.rain] as? Double else{
        return nil
       }
        self.humitity = hum
        self.temperature = (temp - 32) / 1.8
        self.icon = iconStr
        self.rain = rain
        self.summary = sum
    }
}
