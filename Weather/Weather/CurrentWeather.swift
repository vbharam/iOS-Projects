//
//  CurrentWeather.swift
//  Weather
//
//  Created by Vishal Bharam on 9/26/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import UIKit
import Alamofire

public class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName : String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp : Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        
        print("Download Weather Data:")
        
        // Alamofire:
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        
        Alamofire.request(currentWeatherURL!).responseJSON { response in
            // print(response.request)  // original URL request
            // print(response.response) // HTTP URL response
            // print(response.data)     // server data
            // print(response.result.value)   // result of response serialization
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if var currentTemperature = main["temp"] as? Double {
                        currentTemperature -= 273.15
                        self._currentTemp = round(10 * currentTemperature)/10
                    }
                }
            }
            
            completed()
        }
    }
    
}
