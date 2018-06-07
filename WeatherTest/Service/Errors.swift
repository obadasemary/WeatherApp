//
//  Errrors.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation
import Moya
import ReSwift
import SwiftyJSON

extension MoyaError: Action {
}

public enum ServerError: Equatable, Swift.Error, Action {
    case failed(code: Int, message: String, friendly: String, data: JSON)
}
