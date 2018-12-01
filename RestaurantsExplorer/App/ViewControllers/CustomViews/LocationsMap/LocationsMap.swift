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

struct LocationInMap {
    let locationId: String
    let title: String
    let latitude: Double
    let longitude: Double
}

class LocationsMap: UIView {
    
    private var mapView = MKMapView()
    private var displayingAnnotations = [MKPointAnnotation]()
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setLocations(locationsInMap: [LocationInMap]) {
        self.displayingAnnotations.removeAll()
        
        locationsInMap.forEach { location in
            let annotation = self.createAnnotation(forLocation: location)
            self.mapView.addAnnotation(annotation)
            self.displayingAnnotations.append(annotation)
        }
        
        self.centerToDisplayingAnnotations()
    }
    
    // MARK: - Creating Annotations
    
    private func createAnnotation(forLocation: LocationInMap) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: forLocation.latitude, longitude: forLocation.longitude)
        annotation.coordinate = centerCoordinate
        annotation.title = forLocation.title
        return annotation
    }
    
    // MARK: - Controlling Map
    
    private func centerToDisplayingAnnotations() {
        self.mapView.showAnnotations(self.displayingAnnotations, animated: true)
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
