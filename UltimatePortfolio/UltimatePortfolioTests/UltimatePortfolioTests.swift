//
//  UltimatePortfolioTests.swift
//  UltimatePortfolioTests
//
//  Created by Jae Won Lee on 2022/04/17.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
