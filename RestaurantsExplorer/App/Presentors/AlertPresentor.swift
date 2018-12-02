//
//  AlertPresentor.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 02/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit

struct AlertPresentorOptions {
    let titie: String
    let message: String
    let okTitle: String
    let cancelTitle: String?
    let okHandler: (() -> Void)?
    let cancelHandler: (() -> Void)?
    let onVC: UIViewController
}

class AlertPresentor {
    static func showAlert(options: AlertPresentorOptions) {
        let alert = UIAlertController(title: options.titie, message: options.message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: options.okTitle, style: .default, handler: {  _ in
            options.okHandler?()
        }))
        
        if let cancelTitle = options.cancelTitle {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: {  _ in
                options.cancelHandler?()
            }))
        }
        
        options.onVC.present(alert, animated: true, completion: nil)
    }
}
