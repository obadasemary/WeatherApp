//
//  Initialize.swift
//  FOTV
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Changeable
import Foundation
import ReSwift
import SwiftyJSON

public class Redux {
    public static var store: Store<Changeable<AppState>>!

    static var app: Changeable<AppState>!

    static func boot(debugEnabled _: Bool = true) {
        let appValue = SaveApplicationActor.restoreApplication()
        app = Changeable<AppState>(value: appValue)
        app.commit()

        store = Store<Changeable<AppState>>(reducer: appReducer, state: app)
    }
}

struct EmptyAction: Action {
}

extension Array: Action {
}

extension Dictionary: Action {
}
