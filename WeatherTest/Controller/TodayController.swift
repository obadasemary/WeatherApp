//
//  TodayController.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 7.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import UIKit
import Rswift
import ReSwift
import SwiftyJSON
import Changeable
import SwiftSpinner
import Solar
import CoreLocation

class TodayController: UIViewController, StoreSubscriber {

    typealias StoreSubscriberStateType = Changeable<AppState>
    var value: AppState = Redux.store.state.value

    var todayList: JSON = JSON.null

    @IBOutlet var imageWeather: UIImageView!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var labelHumidity: UILabel!
    @IBOutlet var labelDegree: UILabel!
    @IBOutlet var labelSpeed: UILabel!
    @IBOutlet var labelDirection: UILabel!
    @IBOutlet var labelNem: UILabel!

    var isFirstLaunch = true
    var solar: Solar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = R.image.forecast.lineRainbow()
        SwiftSpinner.show("Connecting to weather...")

        // We should subscribe for state
        Redux.store.subscribe(self) {
            $0.select { (state: Changeable<AppState>) -> Changeable<AppState> in
                state
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationHelper.updateLocation()
    }

    // MARK: - Redux State
    func newState(state: Changeable<AppState>) {
        value = state.value

        // Using Weather Data
        if state.lastChanges.contains(\AppState.todayList) {
            todayList = state.value.todayList
            setStackView()
        }

        // Showing location latidute and langitude
        if state.lastChanges.contains(\AppState.locationCount) {
            if state.value.locationCount != [] {
                let latidute: Double = state.value.locationCount[0].doubleValue
                let langitude: Double = state.value.locationCount[1].doubleValue

                let c2D = CLLocationCoordinate2D(latitude: latidute, longitude: langitude)
                solar = Solar(for: Date(), coordinate: c2D)!

                Redux.store.dispatch(AppState.getToday(lat: latidute, long: langitude))
            } else {
                SwiftSpinner.hide()
                self.showMessage("Error!", "Please check your allow location access", 3)
            }
        }

        isFirstLaunch = false
    }

    // MARK: - StackView
    func setStackView() {
        let mainImage: String = AppState.getMainRespose(desc: todayList["weather"][0]["description"].stringValue)

        if solar.isDaytime {
            imageWeather.image = UIImage(named: "Forecast/\(mainImage)\("_day")")
        } else if solar.isNighttime {
            imageWeather.image = UIImage(named: "Forecast/\(mainImage)\("_night")")
        }

        labelLocation.text = todayList["name"].stringValue

        let degree = "\("\(todayList["main"]["temp"].floatValue.celsius())".intValue)"
        let desc = todayList["weather"][0]["description"].stringValue.capitalized
        labelDescription.text = "\(degree)\("°C") | \(desc)"

        labelHumidity.text = "\(todayList["main"]["humidity"].stringValue)\("%")"
        labelSpeed.text = "\(todayList["wind"]["speed"].intValue) \("km\\h")"
        labelDegree.text = "\(todayList["main"]["pressure"].intValue) \("hPa")"

        labelDirection.text = todayList["wind"]["deg"].floatValue.windDirectionFromDegrees()
        labelNem.text = "\(todayList["clouds"]["all"].intValue) \("mm")"
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        let message = "\(labelLocation.text!) \("Weather Forecast"): \(String(describing: labelDescription.text!))"
        let objectsToShare = [message] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
}
