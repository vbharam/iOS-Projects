//
//  Location.swift
//  Weather
//
//  Created by Vishal Bharam on 9/29/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
