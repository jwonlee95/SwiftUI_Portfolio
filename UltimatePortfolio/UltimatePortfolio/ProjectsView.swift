//
//  ProjectsView.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/24.
//

import SwiftUI

/// Main tab views for open and closed tabs.
struct ProjectsView: View {
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingSortOrder = false
    
    @State private var sortOrder = Item.SortOrder.optimized
//    @State private var sortingKeyPath: PartialKeyPath<Item>?
//    @State private var sortDescriptor: NSSortDescriptor?
    
    let sortingKeyPaths = [
        \Item.itemTitle,
        \Item.itemCreationDate
    ]
    
    let showClosedProjects: Bool
    
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        //Fetch Data
        projects = FetchRequest<Project>(entity: Project.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
            ], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }
    
    //  To clean up the code, this part contains data that is dealing with in the same page. This makes it difficult if we make another swiftUI View file. In this case, we can make another view variable with same structure as body.
    
    /// List of projects including items inside. This is the Main contents.
    var projectsList: some View {
        List {
            ForEach(projects.wrappedValue) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: sortOrder)) { item in
                        ItemRowView(project: project, item: item)
                    }
                    .onDelete { offsets in
                        delete(offsets, from: project)
                    }
                }
                
                if showClosedProjects == false {
                    Button {
                            addItem(to: project)
                    } label: {
                        Label("Add New Item", systemImage: "plus")
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    /// App project button on the right top corner
    var addProjectToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if showClosedProjects == false {
                Button(action: addProject,  label: {
                    Label("Add Project", systemImage: "plus")
                })
            }
        }
    }
    
    /// Sort button on the left top corener
    var sortOrderToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if projects.wrappedValue.isEmpty {
                    Text("There's nothing here right now")
                        .foregroundColor(.secondary)
                } else {
                    projectsList
                }
            }
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { sortOrder = .optimized },
                    .default(Text("Creation Date")) { sortOrder = .creationDate },
                    .default(Text("Title")) { sortOrder = .title }
                ])
            }
            
            // This view is used for landscape mode of big screen devices. It will show the content on the menu bar on the left so we have to provide seperate view for it.
            SelectSomethingView()
        }
    }
    
    /// Creates a new project which a default value set in Project-CoreDataHelpers file.
    func addProject() {
        withAnimation {
            let project = Project(context: managedObjectContext)
            project.closed = false
            project.creationDate = Date()
            dataController.save()
        }
    }
    
    /// Creates a new item which a default value set in Item-CoreDataHelpers file.
    func addItem(to project: Project) {
        withAnimation {
            let item = Item(context: managedObjectContext)
            item.project = project
            item.creationDate = Date()
            dataController.save()
        }
    }
    
    /// Deletes selected item by swiping left.
    /// - Parameters:
    ///   - offsets: Position of the item
    ///   - project: Owner project of the selected item
    func delete(_ offsets: IndexSet, from project: Project) {
        let allItems = project.projectItems(using: sortOrder)
        for offset in offsets {
            let item = allItems[offset]
            dataController.delete(item)
        }
         
        dataController.save()
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
