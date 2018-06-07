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
        switch desc.uppercased() {
        case "CLOUDS":
            return "Cloudy"

        case "RAIN", "Thunderstorm":
            return "Lightning"

        case "WIND":
            return "Wind"

        default:
            return "Sun"
        }
    }
}
