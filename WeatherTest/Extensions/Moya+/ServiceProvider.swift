//
//  ServiceProvider.swift
//  Pods
//
//  Created by Hasan Serdar on 5/12/17.
//
//

import Foundation
import Moya
//import Vendors
import SwiftyJSON

// we overriding Moya default logger whic is not good for printing formatted json data
private func reversedPrint(seperator _: String, terminator _: String, items: Any...) {
    for item in items {
        print("")
        print(item)
        print("")
    }
}

// json plugin should print properly formatted network data.We using SwiftyJSON abilities for this purpose
public let jsonLogger = NetworkLoggerPlugin(verbose: true, cURL: false, output: reversedPrint) {
    data in
    let json = (try? JSON(data: data)) ?? JSON.null
    return json.debugDescription.data(using: .utf8) ?? data
}
