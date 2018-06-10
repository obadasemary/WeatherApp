//
//  ForecastCell.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 7.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

class ForecastCell: UITableViewCell {

    @IBOutlet var imageWeather: UIImageView!
    @IBOutlet var labelDay: UILabel!
    @IBOutlet var labelDegree: UILabel!
    @IBOutlet var labelWeather: UILabel!

    var data: JSON = [] {
        didSet {

            let mainImage: String = AppState.getMainRespose(desc: data["weather"][0]["description"].stringValue)

            let hour = Calendar.current.component(.hour, from: Date())
            if hour >= 6 && hour < 17 {
                imageWeather.image = UIImage(named: "Forecast/\(mainImage)\("_day")")
            } else {
                imageWeather.image = UIImage(named: "Forecast/\(mainImage)\("_night")")
            }

            labelWeather.text = data["weather"][0]["description"].stringValue
            labelDay.text = data["dt_txt"].stringValue.hourOfDay()

            let celsius = data["main"]["temp"].floatValue.celsius()
            let celciusValue = "\(celsius)".intValue
            labelDegree.text = "\(celciusValue)\("°")"
        }
    }
}

