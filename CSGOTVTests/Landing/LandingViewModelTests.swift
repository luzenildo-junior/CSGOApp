//
//  LandingViewModelTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
import Combine
@testable import CSGOTV

class LandingViewModelTests: XCTestCase {
    private var viewModel: LandingViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        viewModel = LandingViewModel()
    }
    
    func test_dismissViewWhenCountdownFinishes() {
        let expectation = expectation(description: "expected to dismiss the view")
        var isFirstPass = true
        
        viewModel.$dismissView
            .sink { value in
                if isFirstPass {
                    XCTAssertFalse(value)
                    isFirstPass = false
                } else {
                    XCTAssertTrue(value)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.startCountdownToDismissView()
        
        waitForExpectations(timeout: 5.0)
    }
}
