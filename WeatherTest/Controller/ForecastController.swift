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
import PullToRefreshKit
import SwiftSpinner
import Solar
import CoreLocation

class ForecastController: UITableViewController, StoreSubscriber {

    typealias StoreSubscriberStateType = Changeable<AppState>
    var value: AppState = Redux.store.state.value

    var items: [JSON] = []
    var dayGroupItems: [JSON] = []
    var dayGroupItem: [JSON] = []
    var dayTitleItems: [JSON] = []

    var isFirstLaunch = true
    var solar: Solar!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationHelper.updateLocation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = R.image.forecast.lineRainbow()
        SwiftSpinner.show("Connecting to weather forecast...")

        Redux.store.subscribe(self) {
            $0.select { (state: Changeable<AppState>) -> Changeable<AppState> in
                state
            }
        }

        /// Refreshing Forecast Data
        tableView.configRefreshHeader(container: self) { [weak self] in
            perform_after(2, closure: {
                self?.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
                LocationHelper.updateLocation()
            })
        }
    }

    // MARK: - REDUX STATE
    func newState(state: Changeable<AppState>) {
        value = state.value

        /// Using City Name for Title
        if state.lastChanges.contains(\AppState.todayList) || isFirstLaunch {
            title = state.value.todayList["name"].stringValue
        }

        /// Using Forecast data
        if state.lastChanges.contains(\AppState.forecastList) {
            removeList()
            items = state.value.forecastList

            var saveDay: String = ""

            for i in 0 ... items.count - 1 {
                let dayName = items[i]["dt_txt"].stringValue.dayOfWeek()
                if dayName != saveDay {
                    dayTitleItems.append(JSON(items[i]))
                }
                saveDay = dayName
            }
            reloadUpdatedData()
        }

        /// Using Location latidute & langitude
        if state.lastChanges.contains(\AppState.locationCount) || isFirstLaunch {
            if state.value.locationCount != [] {
                let latidute: Double = state.value.locationCount[0].doubleValue
                let langitude: Double = state.value.locationCount[1].doubleValue

                let c2D = CLLocationCoordinate2D(latitude: latidute, longitude: langitude)
                solar = Solar(for: Date(), coordinate: c2D)!

                Redux.store.dispatch(AppState.getForecast(lat: latidute, long: langitude))
            } else {
                SwiftSpinner.hide()
                self.showMessage("Error!", "Please check your allow location access", 3)
            }
        }

        isFirstLaunch = false
    }

    // MARK: - Filter
    func reloadUpdatedData() {
        /// Group array are filtered
        ///
        /// - Days are created
        /// - Sections are created

        for j in 0 ... dayTitleItems.count - 1 {
            let dayName = dayTitleItems[j]["dt_txt"].stringValue.dayOfItems()
            dayGroupItem.removeAll()

            for k in 0 ... items.count - 1 {
                if items[k]["dt_txt"].stringValue.dayOfItems() == dayName {
                    dayGroupItem.append(JSON(items[k]))
                }
            }
            dayGroupItems.append(JSON(dayGroupItem))
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dayGroupItems.count - 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayGroupItems[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastCell, for: indexPath)!
        cell.solar = solar
        cell.data = dayGroupItems[indexPath.section][indexPath.row]
        cell.lineLeadingConstraint.constant = 95
        if  indexPath.row == 0   {
            cell.lineLeadingConstraint.constant = 0
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Header Section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastHeaderCell.identifier) as! ForecastHeaderCell
        headerCell.labelDays.text = dayGroupItems[section][section]["dt_txt"].stringValue.dayOfWeek()
        return headerCell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func removeList() {
        items.removeAll()
        dayGroupItems.removeAll()
        dayGroupItem.removeAll()
        dayTitleItems.removeAll()
    }
}
