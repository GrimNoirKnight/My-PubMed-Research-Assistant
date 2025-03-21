//  My_PubMed_Research_AssistantApp.swift
//  My PubMed Research Assistant
//
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
