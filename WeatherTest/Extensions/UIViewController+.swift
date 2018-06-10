//
//  UIViewController+.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 6.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import UIKit

extension UIViewController {
    func showMessage(_ title: String = "", _ message: String = "", _ timeout: Double = 3) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        perform_after(timeout) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}
