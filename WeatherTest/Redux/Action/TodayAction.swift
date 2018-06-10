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
import SwiftSpinner

extension AppState {

    // MARK: - Weather Data
    public static func getToday(lat: Double, long: Double) -> Store<Changeable<AppState>>.AsyncActionCreator {
        return { _, _, callback in

            /// Getting Weather Data - Please check Config/.plist
            todayProvider.request(TodayService.getToday(latitude: lat, longitude: long), completion: { result in
                switch result {
                case let .success(response):
                    SwiftSpinner.hide()
                    
                    let json = response.asJSON()
                    let response = json.asResponse() as TodayResponse
                    return callback({ _, _ in response })

                case let .failure(error):
                    SwiftSpinner.hide()
                    return callback({ _, _ in error })
                }
            })
        }
    }
}
