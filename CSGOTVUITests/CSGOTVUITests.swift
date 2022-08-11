//
//  CSGOTVUITests.swift
//  CSGOTVUITests
//
//  Created by Luzenildo Junior on 04/08/22.
//

import XCTest

class CSGOTVUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func testIfLandingViewAppears() {
        app.launch()
        let landingView = app.otherElements["landing-view"]
        let fuzeLogo = app.images["fuze-logo"]
        
        XCTAssertTrue(landingView.exists)
        XCTAssertTrue(fuzeLogo.exists)
    }
    
    func testIfMatchesViewAppears() {
        app.launch()
        let matchesView = app.otherElements["matches-view"]
        _ = matchesView.waitForExistence(timeout: 6.0)
        
        XCTAssertTrue(matchesView.exists)
    }
    
    func testIfMatchDetailsViewAppears() {
        app.launch()
        
        let matchesTableView = app.tables["matches-tableView"]
        _ = matchesTableView.waitForExistence(timeout: 15.0)
        
        let activityIndicator = app.activityIndicators.element
        expectation(for: NSPredicate(format: "exists == 0"), evaluatedWith: activityIndicator)
        waitForExpectations(timeout: 10.0)
        
        let cell = matchesTableView.descendants(matching: .cell).element(boundBy: 0)
        _ = cell.waitForExistence(timeout: 5.0)
        // sometimes this tap fails. Not completelly sure why, but it does...
        cell.tap()
        
        let matchDetailsView = app.otherElements["match-details-view"]
        let matchDetailsTableView = app.tables["match-details-tableView"]
        
        XCTAssertTrue(matchDetailsView.exists)
        XCTAssertTrue(matchDetailsTableView.exists)
    }
}
