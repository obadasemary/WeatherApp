//
//  AppState.swift
//  FOTV
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Changeable
import Foundation
import Moya
import ReSwift
import SwiftyJSON

public struct AppState: StateType, Codable {
    var moyaError: MoyaError?
    var serverError: ServerError?
    var servers: [JSON] = []
    var selectedServer: JSON = JSON.null

    var forecastList: [JSON] = []
    var todayList: JSON = JSON.null

    public var locationCount: [JSON] = []

    public init() {
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selectedServer = (try? values.decode(JSON.self, forKey: .selectedServer)) ?? JSON.null
        servers = (try? values.decode([JSON].self, forKey: .servers)) ?? []
        forecastList = (try? values.decode([JSON].self, forKey: .forecastList)) ?? []
        todayList = (try? values.decode(JSON.self, forKey: .todayList)) ?? JSON.null
        locationCount = (try? values.decode([JSON].self, forKey: .forecastList)) ?? []
    }

    private enum CodingKeys: String, CodingKey {
        case selectedServer
        case servers
        case forecastList
        case todayList
        case locationCount
    }
}
