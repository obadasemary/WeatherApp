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

    var data: JSON = [] {
        didSet {

            labelDay.text = data["dt_txt"].stringValue

            let mainImage: String = AppState.getMainRespose(desc: data["weather"][0]["main"].stringValue)
            imageWeather.image = UIImage(named: "Forecast/\(mainImage)")
            labelDegree.text = data["weather"][0]["main"].stringValue
        }
    }
}

