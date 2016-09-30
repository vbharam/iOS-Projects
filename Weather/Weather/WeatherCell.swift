//
//  WeatherCell.swift
//  Weather
//
//  Created by Vishal Bharam on 9/26/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(forecast: Forecast) {
        highTemp.text = String(forecast.highTemp)
        lowTemp.text = String(forecast.lowTemp)
        weatherType.text = String(forecast.weatherType)
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
