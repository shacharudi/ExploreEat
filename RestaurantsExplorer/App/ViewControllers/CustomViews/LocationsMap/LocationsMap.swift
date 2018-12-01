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

class LocationAnnotation: MKPointAnnotation {
    var locationId: String?
}

struct LocationInMap {
    let locationId: String
    let title: String
    let latitude: Double
    let longitude: Double
}

protocol LocationsMapDelegate: class {
    func didTappedLocation(locationId: String)
}

class LocationsMap: UIView, MKMapViewDelegate {
    
    public weak var delegate: LocationsMapDelegate?
    
    private var mapView = MKMapView()
    private var displayingAnnotations = [LocationAnnotation]()
    
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
    
    private func createAnnotation(forLocation: LocationInMap) -> LocationAnnotation {
        let centerCoordinate = CLLocationCoordinate2D(latitude: forLocation.latitude, longitude: forLocation.longitude)

        let annotation = LocationAnnotation()
        annotation.coordinate = centerCoordinate
        annotation.title = forLocation.title
        annotation.locationId = forLocation.locationId
        
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
        self.mapView.delegate = self
        self.mapView.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? LocationAnnotation {
            guard let locationId = annotation.locationId else {
                Logger.error(message: "LocationAnnotation has no location id!")
                return
            }
            self.delegate?.didTappedLocation(locationId: locationId)
        }
    }
}
