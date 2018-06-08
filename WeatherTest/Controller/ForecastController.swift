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

class ForecastController: UITableViewController, StoreSubscriber {

    typealias StoreSubscriberStateType = Changeable<AppState>
    var value: AppState = Redux.store.state.value

    var items: [JSON] = []
    var dayGroupItems: [JSON] = []
    var dayGroupItem: [JSON] = []
    var dayTitleItems: [JSON] = []

    var isFirstLaunch = true

    func newState(state: Changeable<AppState>) {
        value = state.value

        if state.lastChanges.contains(\AppState.forecastList) {
            items = state.value.forecastList

            var saveDay: String = ""

            for i in 0 ... items.count - 1 {
                var dayName: String = ""
                dayName = dayName.dayOfWeek(s: items[i]["dt_txt"].stringValue)
                if dayName != saveDay {
                    dayTitleItems.append(JSON(items[i]))
                }
                saveDay = dayName
            }

            for j in 0 ... dayTitleItems.count - 1 {
                var dayName = ""
                dayName = dayName.dayOfItems(s: dayTitleItems[j]["dt_txt"].stringValue)
                dayGroupItem.removeAll()

                for k in 0 ... items.count - 1 {
                    let filterName: String = ""
                    if filterName.dayOfItems(s: items[k]["dt_txt"].stringValue) == dayName {
                        dayGroupItem.append(JSON(items[k]))
                    }
                }

                dayGroupItems.append(JSON(dayGroupItem))
            }

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
        navigationController?.navigationBar.shadowImage = R.image.forecast.lineRainbow()

        Redux.store.subscribe(self) {
            $0.select { (state: Changeable<AppState>) -> Changeable<AppState> in
                state
            }
        }

        tableView.configRefreshHeader(container: self) { [weak self] in
            perform_after(2, closure: {
                self?.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
                LocationHelper.updateLocation()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dayGroupItems.count - 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayGroupItems[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastCell, for: indexPath)!
        cell.data = dayGroupItems[indexPath.section][indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastHeaderCell.identifier) as! ForecastHeaderCell
        let title: String = ""
        headerCell.labelDays.text = title.dayOfWeek(s: dayGroupItems[section][section]["dt_txt"].stringValue)
        return headerCell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
