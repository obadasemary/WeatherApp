//
//  SaveUserTokenActor.swift
//  FOTV
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Changeable
import Foundation
import ReSwift
import SwiftyJSON

public class SaveApplicationActor: StoreSubscriber {
    public typealias StoreSubscriberStateType = Changeable<AppState>
    let store: Store<Changeable<AppState>>
    public init(store: Store<Changeable<AppState>>) {
        self.store = store

        self.store.subscribe(self)
    }

    public func newState(state: Changeable<AppState>) {
        if state.lastChanges.count > 0 {
            let jsonEncoder = JSONEncoder()

            if let savedData = try? jsonEncoder.encode(state.value) {
                Vendors.set(value: savedData, forKey: "application")
            } else {
                print("Failed to save people.")
            }
        }
    }

    static func restoreApplication() -> AppState {
        let state: AppState!
        state = AppState()
        return state
    }
}
