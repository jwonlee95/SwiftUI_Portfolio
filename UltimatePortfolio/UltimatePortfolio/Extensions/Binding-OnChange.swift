//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/26.
//

import SwiftUI

extension Binding {
    
    /// Recieves the item or project values and replace the changed value from the original value.
    /// - Parameter handler: update function from Edit View.
    /// - Returns: Changed value.
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(get: { self.wrappedValue }, set: { newValue in
            self.wrappedValue = newValue
            handler()
        }
        )
    }
}
