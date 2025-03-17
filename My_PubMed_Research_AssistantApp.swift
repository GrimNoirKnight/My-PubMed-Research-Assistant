//  My_PubMed_Research_AssistantApp.swift
//  My PubMed Research Assistant
//
//  Description: Entry point for the SwiftUI app, integrating Core Data.
//  Version: 0.0.7-alpha (Core Data Integration, Improved Memory Management)

import SwiftUI
import CoreData

@main
struct My_PubMed_Research_AssistantApp: App {
    let persistenceController = ArticleStorage.shared // ✅ Core Data instance

    var body: some Scene {
        WindowGroup {
            SearchView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext) // ✅ Inject Core Data context
                .onAppear {
                    NotificationCenter.default.addObserver(
                        forName: UIApplication.didReceiveMemoryWarningNotification,
                        object: nil,
                        queue: .main
                    ) { _ in
                        print("⚠️ Memory warning received! Freeing up resources.")
                        URLCache.shared.removeAllCachedResponses()
                    }
                }
        }
    }
}
