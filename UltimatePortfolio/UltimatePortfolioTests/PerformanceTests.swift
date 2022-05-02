//
//  PerformanceTests.swift
//  UltimatePortfolioTests
//
//  Created by Jae Won Lee on 2022/05/03.
//

import XCTest
@testable import UltimatePortfolio

class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformace() throws {
        // Create a significant amount of test data
        for _ in 1...100 {
            try dataController.createSampleData()
        }
        
        // Simulatge lots of awards to check
        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the number of awards is constant. Change this if you add new awards.")
        
        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }

}
