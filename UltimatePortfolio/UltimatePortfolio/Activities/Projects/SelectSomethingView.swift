//
//  SelectSomethingView.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/28.
//

import SwiftUI

/// View for landscape mode of large devices. The main view shows an empty page and a menu bar so it is to let users know what to do when seeing this page.
struct SelectSomethingView: View {
    var body: some View {
        Text("Please select something from the menu to begin")
            .italic()
            .foregroundColor(.secondary)
    }
}

struct SelectSomethingView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSomethingView()
    }
}
