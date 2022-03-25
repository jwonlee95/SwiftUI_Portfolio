//
//  ItemRowView.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/26.
//

import SwiftUI

struct ItemRowView: View {
    //This Row view is made to oberve each change in items. Therefore, needs to use @ObservedObject rather than @StateObject
    @ObservedObject var item: Item
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Text(item.itemTitle)
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: Item.example)
    }
}
