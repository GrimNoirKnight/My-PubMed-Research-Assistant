<<<<<<< HEAD
<<<<<<< HEAD
//  ContentView.swift
//  My PubMed Research Assistant
//
//  Description: Main content view containing navigation.
//  Version: 0.0.1-alpha

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SearchView()
                .navigationTitle("PubMed Search")
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing // Fix input errors
                }
        }
    }
}
=======
//
=======
>>>>>>> c76a8c2 (Backup before Core Data model change)
//  ContentView.swift
//  My PubMed Research Assistant
//
//  Created by Alan D. Keizer on March 23, 2025.
//  © 2025 A. D. Keizer.  All rights reserved.
//
//  Description:
//  Root view that displays the main PubMed search interface.
//
//  Version: 00.001.007-alpha  Removed reference to Item / CoreData preview

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SearchView()
                .navigationTitle("PubMed Search")
        }
    }
}

#Preview {
<<<<<<< HEAD
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
>>>>>>> cc80264 (Flattened directory structure using rsync)
=======
    ContentView()
        .environment(
            \.managedObjectContext,
            ArticleStorage.shared.container.viewContext
        )
} 
>>>>>>> c76a8c2 (Backup before Core Data model change)
