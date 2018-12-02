//
//  Texts.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation

enum Texts {
    static let homeVCViewTitle: String = "ExploreEat"
    static let homeVCSearchTitle: String = "Search"
    static let searchCityNoPreviousSearches = "No Previous Searches"
    static let searchCityHeaderTitle: String = "Previous Searches"
    static let mapViewTitle: String = "Restaurant Map"
    
    enum TrashSearchesAlert {
        static let title = "Clear previous searches?"
        static let message = "Are you sure? this will clear your searches list..."
        static let okButton = "Yes, Clear"
        static let cancelButton = "Cancel"
    }
}
