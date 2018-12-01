//
//  Metrics.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit

enum Metrics {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    enum SearchCityCell {
        static let smallPadding: CGFloat = 5
        static let padding: CGFloat = 10
        static let cellHeight: CGFloat = 54
        static let flagSize = CGSize(width: 30, height: 30)
        static let flagCornetRadius: CGFloat = 4
    }
}
