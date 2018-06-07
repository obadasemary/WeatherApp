//
//  AppDelegate.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import ReSwift
import SwiftyJSON
import Changeable

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, StoreSubscriber {
    typealias StoreSubscriberStateType = Changeable<AppState>

    var window: UIWindow?
    var database: DatabaseReference!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        AppConfig.configure(application: application, launchOptions: launchOptions ?? [:])

        Redux.boot()
        Redux.store.subscribe(self)

        FirebaseApp.configure()
        database = Database.database().reference()

        window?.rootViewController = R.storyboard.mainTab().instantiateInitialViewController()

        return true
    }

    func newState(state: Changeable<AppState>) {
        if state.lastChanges.contains(\AppState.moyaError) {
            if let error = state.value.moyaError {
                window?.rootViewController?.showMessage(error.errorDescription ?? "")
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
