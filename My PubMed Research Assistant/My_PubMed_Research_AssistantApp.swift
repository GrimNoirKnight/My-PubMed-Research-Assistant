//
//  My_PubMed_Research_AssistantApp.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/14/25.
//

import SwiftUI

@main
struct My_PubMed_Research_AssistantApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
