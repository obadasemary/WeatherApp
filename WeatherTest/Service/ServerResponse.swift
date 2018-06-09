//
//  ServerResponse.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation
import ReSwift
import SwiftyJSON

protocol BaseServerResponse: Action {
    var cnt: Int { get }
    var message: String { get }
    var cityName: String { get }
    var data: JSON { get }
    var raw: JSON { get }

    func asError() -> ServerError

    static func construct(raw: JSON) -> Self
}

extension BaseServerResponse {
    var cnt: Int {
        return raw["cnt"].intValue
    }

    var message: String {
        return raw["message"].stringValue
    }

    var cityName: String {
        return raw["city"]["name"].stringValue
    }

    var data: JSON {
        return raw["list"]
    }

    func asError() -> ServerError {
        return ServerError.failed(code: cnt, message: message, friendly: cityName, data: data)
    }
}

struct ForecastResponse: BaseServerResponse {
    var raw: JSON

    static func construct(raw: JSON) -> ForecastResponse {
        return ForecastResponse(raw: raw)
    }
}

struct TodayResponse: BaseServerResponse {
    var raw: JSON

    static func construct(raw: JSON) -> TodayResponse {
        return TodayResponse(raw: raw)
    }
}

extension JSON {
    func asResponse<T: BaseServerResponse>() -> T {
        return T.construct(raw: self)
    }
}

class ServerResponse: Equatable, Action {
    static func == (lhs: ServerResponse, rhs: ServerResponse) -> Bool {
        return lhs.cnt == rhs.cnt && lhs.message == rhs.message && lhs.data == rhs.data
    }

    init(cnt: Int, message: String, cityName: String, data: JSON) {
        self.cnt = cnt
        self.message = message
        self.cityName = cityName
        self.data = data
    }

    let cnt: Int
    let message: String
    let cityName: String
    let data: JSON
}

extension AppState {
    static func getMainRespose(desc: String) -> String {
        switch desc {
        case "clear sky":
            return "clear_sky"
        case "few clouds":
            return "few_clouds"
        case "scattered clouds":
            return "scattered_clouds"
        case "broken clouds":
            return "broken_clouds"
        case "overcast clouds":
            return "broken_clouds"
        case "shower rain":
            return "shower_rain"
        case "rain":
            return "rain"
        case "light rain":
            return "rain"
        case "moderate rain":
            return "rain"
        case "heavy intensity rain":
            return "rain"
        case "very heavy rain":
            return "rain"
        case "extreme rain":
            return "rain"
        case "freezing rain":
            return "rain"
        case "light intensity shower rain":
            return "shower_rain"
        case "heavy intensity shower rain":
            return "shower_rain"
        case "ragged shower rain":
            return "shower_rain"
        case "thunderstorm with light rain":
            return "thunderstorm"
        case "thunderstorm with rain":
            return "thunderstorm"
        case "thunderstorm with heavy rain":
            return "thunderstorm"
        case "thunderstorm":
            return "thunderstorm"
        case "light thunderstorm":
            return "thunderstorm"
        case "heavy thunderstorm":
            return "thunderstorm"
        case "ragged thunderstorm":
            return "thunderstorm"
        case "thunderstorm with light drizzle":
            return "thunderstorm"
        case "thunderstorm with drizzle":
            return "thunderstorm"
        case "thunderstorm with heavy drizzle":
            return "thunderstorm"
        case "light snow":
            return "snow"
        case "snow":
            return "snow"
        case "heavy snow":
            return "snow"
        case "sleet":
            return "snow"
        case "shower sleet":
            return "snow"
        case "light rain and snow":
            return "snow"
        case "rain and snow":
            return "snow"
        case "light shower snow":
            return "snow"
        case "shower snow":
            return "snow"
        case "heavy shower snow":
            return "snow"
        case "mist":
            return "mist"
        default:
            return "mist"
        }
    }
}
