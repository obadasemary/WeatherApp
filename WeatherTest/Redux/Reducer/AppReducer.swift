//
//  AppReducer.swift
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
import UIKit

public func appReducer(action: Action, state: Changeable<AppState>?) -> Changeable<AppState> {
    let _state: Changeable<AppState>!

    if state == nil {
        _state = Changeable<AppState>(value: AppState())
    } else {
        _state = state!
    }

    if let moyaError = action as? MoyaError {
        _state.set(for: \AppState.moyaError, value: moyaError)
    }

    if let serverError = action as? ServerError {
        _state.set(for: \AppState.serverError, value: serverError)
    }

    if let forecastResponse = action as? ForecastResponse {
        _state.set(for: \AppState.forecastList, value: forecastResponse.data.arrayValue)
    }

    if let todayResponse = action as? TodayResponse {
        _state.set(for: \AppState.todayList, value: todayResponse.raw)
    }

    if let locationResponse = action as? LocationAction {
        switch locationResponse {
        case let .updateLocation(locationData):
            _state.set(for: \AppState.locationCount, value: locationData)
            break
        }
    }

    _state.commit()
    return _state
}
