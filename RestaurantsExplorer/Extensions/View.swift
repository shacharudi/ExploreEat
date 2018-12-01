//
//  View.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBottomBorder() {
        let seperatorView = UIView(frame: .zero)
        self.addSubview(seperatorView)
        seperatorView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets.zero, excludingEdge: .top)
        seperatorView.autoSetDimension(.height, toSize: 1)
        seperatorView.backgroundColor = Colors.seperator
    }
}
