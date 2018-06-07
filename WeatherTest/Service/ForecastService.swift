//
//  HomeService.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

public enum ForecastService {
    case getForecast(latitude: Double, longitude:Double)
}

public var forecastProvider = MoyaProvider<ForecastService>()

extension ForecastService: TargetType {
    public var baseURL: URL {
        return URL(string: AppConfig.Forecast)!
    }

    public var path: String {
        switch self {
        case let .getForecast:
            return ""
        }
    }

    public var validate: Bool {
        return true
    }

    public var method: Moya.Method {
        switch self {
        case .getForecast:
            return .get
        }
    }

    public var sampleData: Data {
        switch self {
        case _:
            return Data()
        }
    }

    public var task: Task {
        switch self {
        case let .getForecast(latitude: latitude, longitude: longitude):
            return .requestParameters(parameters: [
                "lat": latitude,
                "lon": longitude,
                "appid": AppConfig.ApiKey
            ], encoding: URLEncoding.default)
        }
    }

    public var headers: [String: String]? {
        switch self {
        case _:
            return DefaultHeaders()
        }
    }
}
