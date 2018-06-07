//
//  Config.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation
import SwiftyJSON

@objc
public class AppConfig: NSObject {
    static var Domain: String = ""

    static var Forecast: String = ""
    static var Current: String = ""
    static var ApiKey: String = ""

    static var application: UIApplication!

    static var isDebug: Bool = false
    static var isRelease: Bool = false
    static var isStaging: Bool = false

    static func configure(application: UIApplication, launchOptions _: [AnyHashable: Any]) {
        self.application = application
        loadFromPlist()
    }

    static func loadFromPlist() {
        var resourceName: String = "DEBUG"

        #if RELEASE
        isRelease = true

        #endif

        #if STAGING
        isStaging = true
        #endif

        #if DEBUG
        isDebug = true
        #endif

        switch (isDebug, isStaging, isRelease) {
        case (false, false, true):
            resourceName = "RELEASE"

        case (true, true, false):
            resourceName = "STAGING"

        case (true, false, false):
            resourceName = "DEBUG"

        default:
            break
        }

        let path = Bundle.main.path(forResource: resourceName, ofType: "plist")!

        let json = JSON(NSDictionary(contentsOfFile: path) as? Dictionary<String, Any> ?? [:])

        Domain = json["Domain"].stringValue
        Forecast = json["Forecast"].stringValue
        Current = json["Current"].stringValue
        ApiKey = json["ApiKey"].stringValue
    }
}
