//
//  Router.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import DeepLinkKit
import Foundation
import ReSwift
import SwiftyJSON

@objc protocol RouteHandler: class {
    var path: RouteKey { get }
    var handler: DPLRouteHandlerBlock { get }
}

protocol AuthorizedRouteHandler: RouteHandler {
}

protocol Navigatable {
    var parameters: [String: Any] { get set }
}

extension AuthorizedRouteHandler {
    static func performIfAuthorized(_ handler: () -> Void) {
        handler()
    }
}

struct RouteAction: Action {
    let key: RouteKey
    let parameters: [String: Any]
    let url: String
}

struct RouteFragment: CustomStringConvertible {
    let key: RouteKey
    let value: String?

    var description: String {
        return ""
    }
}

@objc enum RouteKey: Int, Codable {
    case home

    var text: String {
        switch self {

        case .home:
            return "home"
        }
    }
}
