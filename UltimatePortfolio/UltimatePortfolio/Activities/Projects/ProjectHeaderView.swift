//
//  ProjectHeaderView.swift
//  UltimatePortfolio
//
//  Created by Jae Won Lee on 2022/03/26.
//

import SwiftUI

/// A View that shows project name, progress bar and Edit button. It is displayed on open and closed tab.
struct ProjectHeaderView: View {
    @ObservedObject var project: Project
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)
                
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }
            
            Spacer()
            
            NavigationLink(destination: EditProjectView(project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }
        .padding(.bottom, 10)
        .accessibilityElement(children: .combine)
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
