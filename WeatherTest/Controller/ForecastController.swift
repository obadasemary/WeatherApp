//
//  ForecastController.swift
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

class ForecastController: UITableViewController, StoreSubscriber {

    typealias StoreSubscriberStateType = Changeable<AppState>
    var value: AppState = Redux.store.state.value

    var items: [JSON] = []

    var isFirstLaunch = true

    func newState(state: Changeable<AppState>) {
        value = state.value

        if state.lastChanges.contains(\AppState.forecastList) {
            items = state.value.forecastList
            tableView.reloadData()
        }

        if state.lastChanges.contains(\AppState.locationCount) {
            items = state.value.forecastList
            tableView.reloadData()
        }

        if state.lastChanges.contains(\AppState.locationCount) || isFirstLaunch {

            if state.value.locationCount != [] {
                let latidute: Double = state.value.locationCount[0].doubleValue
                let langitude: Double = state.value.locationCount[1].doubleValue
                Redux.store.dispatch(AppState.getForecast(lat: latidute, long: langitude))
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

        Redux.store.subscribe(self) {
            $0.select { (state: Changeable<AppState>) -> Changeable<AppState> in
                state
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastCell, for: indexPath)!
        cell.data = items[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
