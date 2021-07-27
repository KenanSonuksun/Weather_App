//
//  ViewController.swift
//  weatherApp
//
//  Created by Pars arge on 14.07.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblRain: UILabel!
    @IBOutlet weak var lblHumitity: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var refresIndicator: UIActivityIndicatorView!
    
    let client = ApiClient()
    var locationManager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
       
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue : CLLocationCoordinate2D = manager.location!.coordinate
        let clientCoordinate = Coordinate(latitude: locationValue.latitude, longitude: locationValue.longitude)
        print(clientCoordinate.latitude)
        print(clientCoordinate.longitude)
        updateWeather(coordinate: clientCoordinate)
        
    }
    func showModel(model : CurrentWeatherModel) {
        let date = NSDate() // Get Todays Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate: String = dateFormatter.string(from: date as Date)
        lblTemp.text = model.temperature
        lblRain.text = model.rain
        lblHumitity.text = model.humitity
        lblSummary.text = model.summary
        icon.image = model.icon
        lblDate.text = stringDate
        refresIndicator.stopAnimating()
    }
    func updateWeather(coordinate : Coordinate) {
        client.getCurrentWeather(at: coordinate){ currentWeather,error in
            
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                
                DispatchQueue.main.sync {
                    self.showModel(model: viewModel)
                }
                
            }
        }
        
    }
    @IBAction func btnRefresh(_ sender: Any) {
        refresIndicator.startAnimating()
        locationManager(locationManager, didUpdateLocations: [])
    }


}

