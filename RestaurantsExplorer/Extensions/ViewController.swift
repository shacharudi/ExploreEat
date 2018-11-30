//
//  ViewController.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func addSubviewVC(viewController: UIViewController) {
        viewController.willMove(toParent: self)
        self.view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
