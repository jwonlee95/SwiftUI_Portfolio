//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/26.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(get: { self.wrappedValue }, set: { newValue in
            self.wrappedValue = newValue
            handler()
        }
        )
    }
}
