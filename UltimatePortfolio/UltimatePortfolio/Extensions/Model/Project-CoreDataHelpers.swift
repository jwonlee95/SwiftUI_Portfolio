//
//  Project-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/24.
//

import SwiftUI

extension Project {
    static let colors = ["Pink", "Purple", "Red", "Orange", "Gold", "Green", "Teal", "Light Blue", "Dark Blue", "Midnight", "Dark Gray", "Gray"]
    
    var projectTitle: String {
        title ?? NSLocalizedString("New Project", comment: "Create a new project")
    }
    
    var projectDetail: String {
        detail ?? ""
    }
    
    var projectColor: String {
        color ?? "Light Blue"
    }
    
    var projectItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }
    
    /// Default Sort type which is optimized in our project. The order of sorting goes as,
    ///  1. Not completed -> Completed
    ///  2. Ones that have higher priority
    ///  3. Created Date
    var projectItemsDefaultSorted: [Item] {
        projectItems.sorted { first, second in
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }
            
            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }
            
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    
    /// Calculates the completion amount of a project.
    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }
        
        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }

    var label: LocalizedStringKey {
        LocalizedStringKey("\(projectTitle), \(projectItems.count) items, \(completionAmount * 100, specifier: "%g")% complete.")
    }
    
    static var example: Project {
        let controller = DataController.preview
        let viewContext = controller.container.viewContext
        
        let project = Project(context: viewContext)
        project.title = "Example Project"
        project.detail = "This is an example project"
        project.closed = true
        project.creationDate = Date()
         
        return project
    }
    
    ///  Sort items by given method from a user.
    /// - Parameter sortOrder: Sorting method chosen by the user.
    /// - Returns: Sorted array of items.
    func projectItems(using sortOrder: Item.SortOrder) -> [Item] {
        //I have used enum method for sorting
        switch sortOrder {
        case .optimized:
            return projectItemsDefaultSorted
        case .title:
            return projectItems.sorted(by: \Item.itemTitle)
        case .creationDate:
            return projectItems.sorted(by: \Item.itemCreationDate)
        }
        
        
        // When using keyPath method for sorting
//        guard let sortingKeyPath = sortingKeyPath else {
//            return project.projectItemsDefaultSorted
//        }
//
//        return project.projectItems.sorted(by: sortingKeyPath)
    }
}
