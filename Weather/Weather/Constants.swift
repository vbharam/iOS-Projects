//
//  Constants.swift
//  Weather
//
//  Created by Vishal Bharam on 9/26/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "a9812df1de41e9752f10b3b429f640f2"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=a9812df1de41e9752f10b3b429f640f2"


typealias DownloadComplete = () -> ()
