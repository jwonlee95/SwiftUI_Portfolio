//
//  ExtensionTests.swift
//  UltimatePortfolioTests
//
//  Created by Jae Won Lee on 2022/05/02.
//

import XCTest
@testable import UltimatePortfolio

class ExtensionTests: XCTestCase {
// Sorting array of integers using KeyPath Method from Sequence_Sorting.swift file.
    func testSequenceKeyPathSortingSelf() {
        let items = [1, 4, 3, 2, 5]
        let sortedItems = items.sorted(by: \.self)
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "The sorted numbers must be ascending.")
    }
    
    func testSequenceKeypathSoringCustom() {
        struct Example: Equatable {
            let value: String
        }
        
        let example1 = Example(value: "a")
        let example2 = Example(value: "b")
        let example3 = Example(value: "c")
        let array = [example1, example2, example3]
        
        let sortedItems = array.sorted(by: \.value) {
            $0 > $1
        }
        
        XCTAssertEqual(sortedItems, [example3, example2, example1])
    }
    
// Testing Bundle-Decoder
    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }
    
// Testing Custom made json files in Fixtures folder.
    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(data, "Hello, World")
    }
    
    func testDecodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode([String: Int].self, from: "DecodableDictionary.json")
        XCTAssertEqual(data.count, 3, "There should be 3 items decoded from DecodableDictionary.json file.")
        XCTAssertEqual(data["One"], 1, "The dictionary should contain Int to String mappings.")
    }
}
