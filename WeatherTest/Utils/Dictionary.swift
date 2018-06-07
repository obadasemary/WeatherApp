//
//  Dictionary.swift
//  Pods
//
//  Created by Admin on 11/24/16.
//
//

import Foundation
import UIKit

public extension Dictionary {
    /// SwifterSwift: Check if key exists in dictionary.
    ///
    ///        let dict: [String : Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
    ///        dict.has(key: "testKey") -> true
    ///        dict.has(key: "anotherKey") -> false
    ///
    /// - Parameter key: key to search for
    /// - Returns: true if key exists in dictionary.
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    /// SwifterSwift: Remove all keys of the dictionary.
    ///
    ///        var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        dict.removeAll(keys: ["key1", "key2"])
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    /// - Parameter keys: keys to be removed
    public mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }

    /// SwifterSwift: JSON Data from dictionary.
    ///
    /// - Parameter prettify: set true to prettify data (default is false).
    /// - Returns: optional JSON Data (if applicable).
    public func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }

    /// SwifterSwift: JSON String from dictionary.
    ///
    ///        dict.jsonString() -> "{"testKey":"testValue","testArrayKey":[1,2,3,4,5]}"
    ///
    ///        dict.jsonString(prettify: true)
    ///        /*
    ///        returns the following string:
    ///
    ///        "{
    ///        "testKey" : "testValue",
    ///        "testArrayKey" : [
    ///            1,
    ///            2,
    ///            3,
    ///            4,
    ///            5
    ///        ]
    ///        }"
    ///
    ///        */
    ///
    /// - Parameter prettify: set true to prettify string (default is false).
    /// - Returns: optional JSON String (if applicable).
    public func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }

    /// SwifterSwift: Count dictionary entries that where function returns true.
    ///
    /// - Parameter where: condition to evaluate each tuple entry against.
    /// - Returns: Count of entries that matches the where clousure.
    public func count(where condition: @escaping ((key: Key, value: Value)) throws -> Bool) rethrows -> Int {
        var count: Int = 0
        try self.forEach {
            if try condition($0) {
                count += 1
            }
        }
        return count
    }

    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped

    public func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }

        return parameterArray.joined(separator: "&")
    }

    /**
     Add dictionary to self in-place.

     - parameter dictionary: The dictionary to add to self
     */
    public mutating func formUnion(_ dictionary: Dictionary) {
        dictionary.forEach { updateValue($0.1, forKey: $0.0) }
    }

    /**
     Return a dictionary containing the union of two dictionaries

     - parameter dictionary: The dictionary to add
     - returns: The combination of self and dictionary
     */
    public func union(_ dictionary: Dictionary) -> Dictionary {
        var completeDictionary = self
        completeDictionary.formUnion(dictionary)
        return completeDictionary
    }
}

// MARK: - Methods (ExpressibleByStringLiteral)
public extension Dictionary where Key: ExpressibleByStringLiteral {

    // Lowercase all keys in dictionary.
    public mutating func lowercaseAllKeys() {
        // http://stackoverflow.com/questions/33180028/extend-dictionary-where-key-is-of-type-string
        for key in self.keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                self[lowercaseKey] = self.removeValue(forKey: key)
            }
        }
    }
}

/**
 Combine the contents of dictionaries into a single dictionary. Equivalent to `lhs.union(rhs)`.

 - parameter lhs: The first dictionary.
 - parameter rhs: The second dictionary.
 - returns: The combination of the two input dictionaries
 */
public func + <Key, Value>(lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
    return lhs.union(rhs)
}

/**
 Add the contents of one dictionary to another dictionary. Equivalent to `lhs.unionInPlace(rhs)`.

 - parameter lhs: The dictionary in which to add key-values.
 - parameter rhs: The dictionary from which to add key-values.
 */
public func += <Key, Value>(lhs: inout Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) {
    lhs.formUnion(rhs)
}
