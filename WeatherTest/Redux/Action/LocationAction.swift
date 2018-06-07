//
//  HomeAction.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Changeable
import Foundation
import Result
import ReSwift
import SwiftyJSON

extension AppState {
    static func updateLocation(lat: Double, long: Double) -> Store<Changeable<AppState>>.AsyncActionCreator {
        return { _, _, callback in

            var response: [JSON] = []
            response.append(JSON(lat))
            response.append(JSON(long))
            callback({ _, _ in LocationAction.updateLocation(response) })
        }
    }
}

enum LocationAction: Action {
    case updateLocation([JSON])
}
