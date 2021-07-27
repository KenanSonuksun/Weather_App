//
//  Weather.swift
//  weatherApp
//
//  Created by Pars arge on 14.07.2021.
//

import Foundation

struct Weather {
    let currently : CurrentWeather
}

extension Weather {
    init?(json : [String : AnyObject]){
        guard let currentWeatherJson = json["currently"] as? [String : AnyObject],
              let currentWeather = CurrentWeather(json: currentWeatherJson) else {
            return nil
        }
        self.currently = currentWeather
    }
}
