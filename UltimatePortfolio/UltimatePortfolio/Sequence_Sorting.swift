//
//  Sequence_Sorting.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/27.
//

import Foundation
import UIKit

extension Sequence {
    func sorted<Value>(by keyPath: KeyPath<Element, Value>, using areIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            try areIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    func sorted<Value: Comparable>(by KeyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: KeyPath, using: <)
    }
    
    func sorted(by sortDescriptor: NSSortDescriptor) -> [Element] {
        self.sorted {
            sortDescriptor.compare($0, to: $1) == .orderedAscending
        }
    }
    
    func sorted(by sortDescriptors: [NSSortDescriptor]) -> [Element] {
        self.sorted {
            for descriptor in sortDescriptors {
                switch descriptor.compare($0, to: $1) {
                case .orderedAscending:
                    return true
                case .orderedDescending:
                    return false
                case .orderedSame:
                    continue
                }
            }
            
            return false
        }
    }
}
