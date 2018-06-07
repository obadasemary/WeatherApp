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

            labelDay.text = data["dt_txt"].stringValue

            let mainImage: String = AppState.getMainRespose(desc: data["weather"][0]["main"].stringValue)
            imageWeather.image = UIImage(named: "Forecast/\(mainImage)")
            labelWeather.text = data["weather"][0]["main"].stringValue

            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let yourDate = dayFormatter.date(from: data["dt_txt"].stringValue)
            dayFormatter.dateFormat = "EEEE"

            let dayName = dayFormatter.string(from: yourDate!)

            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            hourFormatter.dateFormat = "HH:mm"

            let hourName = hourFormatter.string(from: yourDate!)
            labelDay.text = "\(dayName) \(hourName)"

            let celsius = self.fahrenheit(celsius: data["main"]["humidity"].floatValue)
            let celciusValue = "\(celsius)".intValue
            labelDegree.text = "\(celciusValue) \("°C")"
        }
    }

    func fahrenheit(celsius: Float) -> Float {
        return (celsius - 32) * 0.5556
    }
}

