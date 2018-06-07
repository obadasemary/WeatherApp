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

    var isFirstLaunch = true

    func newState(state: Changeable<AppState>) {
        value = state.value

        if state.lastChanges.contains(\AppState.todayList) {
            todayList = state.value.todayList
            setStackView()
        }

        if state.lastChanges.contains(\AppState.locationCount) || isFirstLaunch {
            if state.value.locationCount != [] {
                let latidute: Double = state.value.locationCount[0].doubleValue
                let langitude: Double = state.value.locationCount[1].doubleValue
                Redux.store.dispatch(AppState.getToday(lat: latidute, long: langitude))
            } else {
                self.showMessage("Error!", "Unable to Share Location", 0)
            }
        }

        isFirstLaunch = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationHelper.updateLocation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = R.image.forecast.lineRainbow()

        Redux.store.subscribe(self) {
            $0.select { (state: Changeable<AppState>) -> Changeable<AppState> in
                state
            }
        }
    }

    func setStackView() {
        let mainImage: String = AppState.getMainRespose(desc: todayList["weather"][0]["main"].stringValue)
        imageWeather.image = UIImage(named: "Forecast/\(mainImage)")
        labelLocation.text = todayList["name"].stringValue

        let degree = "\("\(self.fahrenheit(celsius: todayList["main"]["humidity"].floatValue))".intValue)"
        let desc = todayList["weather"][0]["description"].stringValue
        labelDescription.text = "\(degree)\("°C") | \(desc)"

        labelHumidity.text = todayList["main"]["humidity"].stringValue
        labelSpeed.text = todayList["wind"]["speed"].stringValue
        labelDegree.text = degree
    }

    func fahrenheit(celsius: Float) -> Float {
        return (celsius - 32) * 0.5556
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        let message = "My Location Weather/\(String(describing: labelDescription.text))"
        let objectsToShare = [message] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
}
