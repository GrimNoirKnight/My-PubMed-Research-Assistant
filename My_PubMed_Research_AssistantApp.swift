//  My_PubMed_Research_AssistantApp.swift
//  My PubMed Research Assistant
//
<<<<<<< HEAD
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
=======
//  Description: SwiftUI App entry point, CoreData integrated.
//  Version: 0.0.7-alpha

import SwiftUI

@main
struct My_PubMed_Research_AssistantApp: App {
    let persistenceController = ArticleStorage.shared

    init() {
        // ✅ Disable system keyboard input assistant globally
        UITextField.appearance().inputAssistantItem.leadingBarButtonGroups = []
        UITextField.appearance().inputAssistantItem.trailingBarButtonGroups = []
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
>>>>>>> cc80264 (Flattened directory structure using rsync)
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
