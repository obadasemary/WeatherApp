//
//  TrapReducer.swift
//  UnitTests
//
//  Created by ALI KIRAN on 1/2/18.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Changeable
import FOTV
import Foundation
import ReSwift

struct Trap {
}

func appReducerWithCallback(callback: @escaping (Action, Changeable<AppState>?) -> Void) -> ((Action, Changeable<AppState>?) -> Changeable<AppState>) {
    return { (action: Action, state: Changeable<AppState>?) in
        let state = appReducer(action: action, state: state)
        callback(action, state)
        return state
    }
}

class CallbackStoreSubscriber<T>: StoreSubscriber {
    let handler: (T) -> Void

    init(handler: @escaping (T) -> Void) {
        self.handler = handler
    }

    func newState(state: T) {
        handler(state)
    }
}
