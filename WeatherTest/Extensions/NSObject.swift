//
//  NSObject.swift
//  Pods
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//
//

import Foundation
import UIKit

var AssociatedObjectHandle: UInt8 = 0
public extension NSObject {
    public static func nib(bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: objectName, bundle: bundle)
    }

    public func smartCopy() -> Self {
        return smartCopyObject()
    }

    private func smartCopyObject<T>() -> T {
        return copy() as! T
    }

    public func removeTempObject(key: String) {
        let data = self.tempData.mutableCopy() as! NSMutableDictionary
        data.removeObject(forKey: key)
        self.tempData = data
    }

    public func setTempObject(_ object: Any?, key: String) {
        guard let object = object else {
            removeTempObject(key: key)
            return
        }

        let data = self.tempData.mutableCopy() as! NSMutableDictionary
        data[key] = object
        self.tempData = data
    }

    public func tempObject(key: String) -> Any? {
        return tempData[key]
    }
    
    public func hasTempObject(key: String) -> Bool {
        return tempData[key] != nil
    }

    public var tempData: NSDictionary {
        get {
            guard let data = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? NSDictionary else {
                let dict = NSDictionary()
                self.tempData = dict
                return dict
            }

            return data
        }

        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    public static var namespace: String {
        return NSStringFromClass(self).components(separatedBy: ".").first!
    }

    public var namespace: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").first!
    }

    public static var objectName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    public var objectName: String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
}
