//
//  MoyaResponse.swift
//  Vendors
//
//  Created by Hasan Serdar on 6/27/17.
//

import Foundation
import Moya
import SwiftyJSON

public extension Notification.Name {
    static let API_RESPONSE = Notification.Name("API_RESPONSE")
}

public extension Moya.Response {
    var isOK:Bool {
        do {
            let filteredResponse = try self.filterSuccessfulStatusCodes() // gives back a Response or throws an error.
        }
        catch let error {
            return false
        }

        return true
    }

    public func asJSONValue() -> JSON {
        let result = try? JSON(data: data)
        return result ?? JSON.null
    }

    @discardableResult
    public func asJSON() -> JSON {
        return (try? JSON(data: data)) ?? JSON.null
    }

    public func mapBridgeJSON() -> JSONBridge {
        return JSONBridge(self.asJSONValue())
    }
}
