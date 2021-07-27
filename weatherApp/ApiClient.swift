//
//  ApiClient.swift
//  weatherApp
//
//  Created by Pars arge on 14.07.2021.
//

import Foundation

class ApiClient {
    fileprivate let apiKey = "4cb418bb54aa70da51742e395c441723"
    lazy var baseUrl : URL = {
        URL(string: "https://api.darksky.net/forecast/\(self.apiKey)/")!
        
    }()
    
    let downloader = JsonDownloader()
    
    private func getWeather(at coordinate : Coordinate,completionHandler completion : @escaping (Weather?,Errors?) -> Void){
        
        guard let url = URL(string: coordinate.description, relativeTo: baseUrl)else{
            completion(nil,Errors.UrlError)
            return
        }
        let requestUrl = URLRequest(url: url)
        
         let task = downloader.jsonTask(with: requestUrl) {json,error in
            guard let json = json else{
                completion(nil,error)
                return
            }
            guard let weather = Weather(json: json) else {
                completion(nil, Errors.JsonError)
                return
            }
            
            completion(weather,nil)
            
        }
        task.resume()
    }
    
    func getCurrentWeather(at coordinate : Coordinate, completionHandler completion : @escaping (CurrentWeather? , Errors?)->Void) {
        getWeather(at: coordinate){weather , error in
            completion(weather?.currently,error)
        }
    }
    
}
