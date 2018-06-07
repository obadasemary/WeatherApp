//
//  AppDelegate.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 7.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Changeable
@testable import WeatherTest
import Moya
import Nimble
import Quick
import Result
import ReSwift
import SwiftyJSON

class AuthorizationEmailLogin: QuickSpec {
    typealias CallbackSubscriber = CallbackStoreSubscriber<Changeable<AppState>>
    var store: Store<Changeable<AppState>>!
    override func spec() {
        var sampleData: Data?
        var sampleStatus: Int = 200

        beforeEach {
            sampleData = nil
            sampleStatus = 200

            self.store = Store<Changeable<AppState>>(reducer: appReducer, state: nil)

            let endpointClosure = { (target: ForecastService) -> Endpoint in
                let url = URL(target: target).absoluteString
                return Endpoint(url: url, sampleResponseClosure: { .networkResponse(sampleStatus, sampleData!) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
            }

            forecastProvider = MoyaProvider<ForecastService>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        }

        describe("Forecast") {
            beforeEach {
            }

            it("if data success") {
                let lat = 50.000
                let long = 55.000
                let sampleDataURL = R.file.forecastWithSuccessJson()!
                sampleData = try! Data(contentsOf: sampleDataURL)
                sampleStatus = 401
                waitUntil { done in
                    self.store.dispatch(AppState.getForecast(lat: lat, long: long)) { state in
                        let forecastData = state.value.forecastList
                        expect(forecastData).toNot(equal(JSON.null))
                        done()
                    }
                }
            }

            it("if data wrong") {
                let lat = 50.000
                let long = 55.000
                let sampleDataURL = R.file.forecastWithFailureJson()!
                sampleData = try! Data(contentsOf: sampleDataURL)
                sampleStatus = 401
                waitUntil { done in
                    self.store.dispatch(AppState.getForecast(lat: lat, long: long)) { state in
                        let authState = state.value.forecastList
                        expect(forecastData).toNot(equal(JSON.null))
                        done()
                    }
                }
            }
        }
    }
}

public func equal<T: Equatable>(_ expectedValue: T?) -> Predicate<T> {
    return Predicate.define("equal <\(stringify(expectedValue))>") { actualExpression, msg in
        let actualValue = try actualExpression.evaluate()
        let matches = actualValue == expectedValue && expectedValue != nil
        if expectedValue == nil || actualValue == nil {
            if expectedValue == nil && actualValue != nil {
                return PredicateResult(
                    status: .fail,
                    message: msg.appendedBeNilHint()
                )
            }
            return PredicateResult(status: .fail, message: msg)
        }
        return PredicateResult(bool: matches, message: msg)
    }
}
