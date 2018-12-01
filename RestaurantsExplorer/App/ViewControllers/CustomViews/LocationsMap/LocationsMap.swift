//
//  LocationsMap.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationsMap: UIView {
    
    private var mapView = MKMapView()
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View UI
    
    private func setupView() {
        self.setupMap()
    }
    
    // MARK: - LocationsMap
    
    private func setupMap() {
        self.addSubview(self.mapView)
        self.mapView.autoPinEdgesToSuperviewEdges()
    }
}
