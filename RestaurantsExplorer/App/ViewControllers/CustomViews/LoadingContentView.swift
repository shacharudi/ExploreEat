//
//  LoadingContentView.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class LoadingContentView: UIView {
    
    private let spinner = UIActivityIndicatorView.init(style: .gray)
    
    init() {
        super.init(frame: .zero)
        self.addSubview(self.spinner)
        self.spinner.autoCenterInSuperview()
        self.spinner.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
