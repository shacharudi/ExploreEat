//
//  RestaurantsExplorerTests.swift
//  RestaurantsExplorerTests
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import XCTest
@testable import RestaurantsExplorer

class RestaurantsExplorerTests: XCTestCase {

    var requestDispatcher: RequestDispatcher!
    var searchLocationsService: SearchLocationsService!
    
    override func setUp() {
        self.requestDispatcher = RequestDispatcher()
        self.searchLocationsService = SearchLocationsService(requestDispatcher: self.requestDispatcher)
    }

    override func tearDown() {}

    func testApp() {
        self.citiesFoundTest()
        self.citiesNotFoundTest()
    }
    
    func citiesFoundTest() {
        let existingCitiesTerm = "te"
        let promise = expectation(description: "Should return with results")
        
        self.searchLocationsService.searchLocation(term: existingCitiesTerm)
            .then { results in
                let citiesCount = results.cities.count
                XCTAssert((citiesCount > 0), "Cities count should be larger then 0")
                promise.fulfill()
            }.catch { error in
                XCTFail("Status code: \(error)")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func citiesNotFoundTest() {
        let nonExistingCitiesTerm = "tejkjkfdsf"
        let promise = expectation(description: "Should return with 0 results")
        
        self.searchLocationsService.searchLocation(term: nonExistingCitiesTerm)
            .then { results in
                let citiesCount = results.cities.count
                XCTAssert((citiesCount == 0), "Cities count should be 0")
                promise.fulfill()
            }.catch { error in
                XCTFail("Status code: \(error)")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
