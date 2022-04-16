//
//  EditItemView.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/25.
//

import SwiftUI

struct EditItemView: View {
    let item: Item
    
    @EnvironmentObject var dataController: DataController
    
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    
    /// Initializes the chosen item from user.
    /// - Parameter item: Selected Item from user.
    init(item: Item) {
        self.item = item
        
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Item name", text: $title.onChange(update))
                TextField("Description", text: $detail.onChange(update))
            }
            
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Toggle("Mark Completed", isOn: $completed.onChange(update))
            }
        }
        .navigationTitle("Edit Item")
        .onDisappear(perform: dataController.save)
//        .onChange(of: title) { _ in update() }
//        .onChange(of: detail) { _ in update() }
//        .onChange(of: priority) { _ in update() }
//        .onChange(of: completed) { _ in update() }
        // -> Write Cleaner using Binding at line 35, 39, 48
    }
    
    func update() {
        //Telling any Obervers that data will change and send update UI to the changed Value
        //Project needs to be changed also because completion amount of Project needs to be updated
        //Both Item and Project class comes from NSManagedObject so they are Obervable
        item.project?.objectWillChange.send()
        
        item.title = title
        item.detail = detail
        item.priority = Int16(priority)
        item.completed = completed
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
