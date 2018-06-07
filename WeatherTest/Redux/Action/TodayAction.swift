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
    public static func getToday(lat: Double, long: Double) -> Store<Changeable<AppState>>.AsyncActionCreator {
        return { _, _, callback in

            todayProvider.request(TodayService.getToday(latitude: lat, longitude: long), completion: { result in
                switch result {
                case let .success(response):

                    let json = response.asJSON()
                    let response = json.asResponse() as TodayResponse
                    return callback({ _, _ in response })

                case let .failure(error):
                    return callback({ _, _ in error })
                }
            })
        }
    }
}
