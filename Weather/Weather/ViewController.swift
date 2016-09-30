//
//  ViewController.swift
//  Weather
//
//  Created by Vishal Bharam on 9/26/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather = CurrentWeather()
    var foreCast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationAuthStatus()
    }
    
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            // Update the location weather:
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    // Update the UI:
                    self.updateMainUI()
                }
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            // locationAuthStatus()
        }
    }
    
    
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Downloading forcast weather data for tableview:
        let forcastURL = URL(string: FORECAST_URL)
        
        Alamofire.request(forcastURL!).responseJSON { response in
            // print(response.request)  // original URL request
            // print(response.response) // HTTP URL response
            // print(response.data)     // server data
            // print(response.result.value)   // result of response serialization
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecastSmaple = Forecast(weatherDict: obj)
                        self.forecasts.append(forecastSmaple)
                    }
                }
                
                // Remove the first entry if don't want to repeat the same date again... 
                // self.forecasts.remove(at: 0)
                
                // Reload the table data:
                self.tableView.reloadData()
            }
            completed()
        }        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let currentForcast = forecasts[indexPath.row]
            cell.configureCell(forecast: currentForcast)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

