//  PersistenceController.swift
//  My PubMed Research Assistant
//
//  Created by Alan D. Keizer on March 23, 2025.
//  © 2025 A. D. Keizer.  All rights reserved.
//
//  Description:
//  This file defines the PersistenceController, a Core Data stack for the app.
//  It manages the NSPersistentContainer used to store, fetch, and persist user data,
//  including stored PubMed articles. It supports both persistent and in-memory stores
//  for testing and production environments.
//
//  Version: 00.000.003-alpha  Fixed property name from abstractText to abstract

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        for i in 0..<5 {
            let newItem = StoredArticle(context: viewContext)
            newItem.title = "Sample Article \(i)"
            newItem.journal = "Mock Journal"
            newItem.authors = "Author \(i)"
            newItem.abstract = "This is a test abstract"
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "My_PubMed_Research_Assistant")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
