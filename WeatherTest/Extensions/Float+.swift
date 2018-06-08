//
//  Float+.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 8.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation

extension Float {
    func windDirectionFromDegrees() -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i: Int = Int((self + 11.25)/22.5)
        return directions[i % 16]
    }

    func celsius() -> Float {
        return  self - 273.15
//        return (self - 32) * 0.5556
    }
}
