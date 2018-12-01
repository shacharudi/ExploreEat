//
//  AppContainerVC.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class AppContainerVC: UIViewController {
    
    private let mainNavigation: MainNavigationController
    
    init(mainNavigation: MainNavigationController) {
        self.mainNavigation = mainNavigation
        super.init(nibName: nil, bundle: nil)
        self.setAppStyling()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.showHomeVC()
    }
    
    private func showHomeVC() {
        self.mainNavigation.view.alpha = 0
        self.addSubviewVC(viewController: self.mainNavigation)
        UIView.animate(withDuration: 0.2) {
            self.mainNavigation.view.alpha = 1
        }
    }
    
    private func setAppStyling() {
        UINavigationBar.appearance().tintColor = Colors.textWhite
        UINavigationBar.appearance().barTintColor = Colors.navigationBar
        UINavigationBar.appearance().isTranslucent = false
    }
}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
