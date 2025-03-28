<<<<<<< HEAD
<<<<<<< HEAD
=======
//
//  ArticleStorage.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


>>>>>>> cc80264 (Flattened directory structure using rsync)
=======
>>>>>>> c76a8c2 (Backup before Core Data model change)
//  ArticleStorage.swift
//  My PubMed Research Assistant
//
<<<<<<< HEAD
//  Description: Manages storing and retrieving PubMed articles from CoreData.
<<<<<<< HEAD
//  Version: 0.1.3-alpha (Added support for new attributes)
=======
//  Version: 0.1.3-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)
=======
//  Created by Alan D. Keizer
//  © 2025 A. D. Keizer. All rights reserved.
//
//  Description:
//  Manages storing and retrieving PubMed articles from Core Data.
//  Responsible for syncing PubMedArticle structs with the StoredArticle
//  entity in the Core Data stack.
//
//  Version: 00.001.023-alpha
//
// Attribute Name          Type      Optional        Notes
// -----------------------+---------+---------------+-----------------------------------------------
// abstract                String    No              Abstract text
// affiliations            String    Yes             Author affiliations
// authors                 String    Yes             List of authors (comma-separated)
// conflictOfInterest      String    Yes             Conflict of interest statement
// dateSaved               Date      No              When article was saved
// doi                     String    Yes             Digital Object Identifier
// fullTextAvailable       Boolean   No              True/False flag
// funding                 String    Yes             Funding sources
// issue                   String    Yes             Issue number
// journal                 String    Yes             Journal name
// keywords                String    Yes             Keywords (comma-separated)
// meSHterms               String    Yes             Medical Subject Headings (comma-separated)
// pages                   String    Yes             Page numbers
// pmcid                   String    Yes             Optional identifier
// pmid                    String    No              Primary identifier
// pubDate                 Date      Yes             Publication date
// title                   String    No              Article title
// volume                  String    Yes             Volume number
// webLink                 String    Yes             Link to article
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)

import Foundation
import CoreData  // Needed to interact with Core Data entities and context

// Singleton class to handle Core Data persistence
class ArticleStorage {
    static let shared = ArticleStorage() // Singleton instance
    let container: NSPersistentContainer // The persistent store container

    // Initialize Core Data container
    private init() {
<<<<<<< HEAD
        container = NSPersistentContainer(name: "PubMedData")
<<<<<<< HEAD

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("❌ CoreData Load Failed: \(error.localizedDescription)")
            } else {
                print("🟢 CoreData Store Loaded: \(storeDescription.url?.absoluteString ?? "Unknown Path")")
=======
=======
        container = NSPersistentContainer(name: "My_PubMed_Research_Assistant") // Matches xcdatamodeld name
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("❌ CoreData Load Failed: \(error.localizedDescription)")
            } else {
                print("🟢 CoreData Store Loaded: \(desc.url?.absoluteString ?? "Unknown")")
>>>>>>> cc80264 (Flattened directory structure using rsync)
            }
        }
    }

<<<<<<< HEAD
<<<<<<< HEAD
    // ✅ Save Articles to CoreData
    func saveArticles(_ articles: [PubMedArticle]) {
        let context = container.newBackgroundContext()

        context.perform {
            for article in articles {
                let fetchRequest: NSFetchRequest<StoredArticle> = StoredArticle.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "pmid == %@", article.pmid)

                do {
                    let existingArticles = try context.fetch(fetchRequest)
                    let storedArticle = existingArticles.first ?? StoredArticle(context: context)

                    storedArticle.pmid = article.pmid
                    storedArticle.pmcid = article.pmcid
                    storedArticle.doi = article.doi
                    storedArticle.title = article.title
                    storedArticle.abstract = article.abstract
                    storedArticle.webLink = article.webLink
                    storedArticle.authors = article.authors?.joined(separator: ", ")
                    storedArticle.affiliations = article.affiliations?.joined(separator: "; ")
                    storedArticle.keywords = article.keywords?.joined(separator: ", ")
                    storedArticle.journal = article.journal
                    storedArticle.pubDate = article.pubDate
                    storedArticle.volume = article.volume
                    storedArticle.issue = article.issue
                    storedArticle.pages = article.pages
                    storedArticle.meSHterms = article.meSHterms?.joined(separator: ", ")
                    storedArticle.funding = article.funding?.joined(separator: "; ")
                    storedArticle.conflictOfInterest = article.conflictOfInterest
                    storedArticle.fullTextAvailable = article.fullTextAvailable
                    storedArticle.dateSaved = Date()
                } catch {
                    print("❌ Error checking existing articles: \(error.localizedDescription)")
=======
=======
    // Save array of PubMedArticle structs into Core Data
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
    func saveArticles(_ articles: [PubMedArticle]) {
        let context = container.newBackgroundContext()
        context.perform {
            for article in articles {
                let pmid = article.pmid

                let fetch: NSFetchRequest<StoredArticle> = StoredArticle.fetchRequest()
                fetch.predicate = NSPredicate(format: "pmid == %@", pmid)

            
                do {
                    let results = try context.fetch(fetch)
                    let stored = results.first ?? StoredArticle(context: context)

                    // Assign values to Core Data entity (alphabetical order with comments)
                    stored.abstract = article.abstract                                             // Required string.
                    stored.affiliations = article.affiliations?.joined(separator: "; ")            // Optional string.
                    stored.authors = article.authors?.joined(separator: ", ")                      // Optional string.
                    stored.conflictOfInterest = article.conflictOfInterest                         // Optional string.
                    stored.dateSaved = Date()                                                      // Optional date.
                    stored.doi = article.doi                                                       // Optional string.
                    stored.fullTextAvailable = article.fullTextAvailable                           // Required Bool.
                    stored.funding = article.funding?.joined(separator: "; ")                      // Optional string.
                    stored.issue = article.issue                                                   // Optional string.
                    stored.journal = article.journal                                               // Optional string.
                    stored.keywords = article.keywords?.joined(separator: ", ")                    // Optional string.
                    stored.meSHterms = article.meSHterms?.joined(separator: ", ")                  // Optional string.
                    stored.pages = article.pages                                                   // Optional string.
                    stored.pmcid = article.pmcid                                                   // Optional string.
                    stored.pmid = article.pmid                                                     // Required string.
                    stored.pubDate = article.pubDate                                               // Required date.
                    stored.title = article.title                                                   // Required string.
                    stored.volume = article.volume                                                 // Optional string.
                    stored.webLink = article.webLink                                               // Optional string.

                } catch {
                    print("❌ Error fetching existing article: \(error)")
>>>>>>> cc80264 (Flattened directory structure using rsync)
                }
            }

            do {
                try context.save() // Commit all changes to disk
                print("🟢 Articles saved to CoreData.")
            } catch {
<<<<<<< HEAD
                print("❌ Failed to save articles: \(error.localizedDescription)")
=======
                print("❌ Failed to save articles: \(error)")
>>>>>>> cc80264 (Flattened directory structure using rsync)
            }
        }
    }

<<<<<<< HEAD
<<<<<<< HEAD
    // ✅ Load Cached Articles from CoreData
    func loadCachedArticles(for query: String) -> [PubMedArticle] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<StoredArticle> = StoredArticle.fetchRequest()

        do {
            let storedArticles = try context.fetch(fetchRequest)
            let articles = storedArticles.compactMap { object -> PubMedArticle? in
                return PubMedArticle(
                    pmid: object.pmid,
                    pmcid: object.pmcid,
                    doi: object.doi,
                    title: object.title,
                    abstract: object.abstract ?? "Abstract not available",
                    webLink: object.webLink ?? "",
                    authors: object.authors?.components(separatedBy: ", "),
                    affiliations: object.affiliations?.components(separatedBy: "; "),
                    keywords: object.keywords?.components(separatedBy: ", "),
                    journal: object.journal,
                    pubDate: object.pubDate,
                    volume: object.volume,
                    issue: object.issue,
                    pages: object.pages,
                    meSHterms: object.meSHterms?.components(separatedBy: ", "),
                    funding: object.funding?.components(separatedBy: "; "),
                    conflictOfInterest: object.conflictOfInterest,
                    fullTextAvailable: object.fullTextAvailable
                )
            }

            print("🟢 Loaded \(articles.count) cached articles from CoreData.")
            return articles
        } catch {
            print("❌ Failed to load cached articles: \(error.localizedDescription)")
=======
=======
    // Load saved articles, converting them back to PubMedArticle structs
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
    func loadCachedArticles(for query: String) -> [PubMedArticle] {
        let context = container.viewContext
        let fetch: NSFetchRequest<StoredArticle> = StoredArticle.fetchRequest()

        do {
            let stored = try context.fetch(fetch)
            return stored.map { self.convertStoredToPubMedArticle($0) }
        } catch {
            print("❌ Load failed: \(error)")
>>>>>>> cc80264 (Flattened directory structure using rsync)
            return []
        }
    }

    // Convert StoredArticle to PubMedArticle with safe default values
    private func convertStoredToPubMedArticle(_ obj: StoredArticle) -> PubMedArticle {
        // Break long chained expression for compiler stability
        let abstract = obj.abstract // Corrected line                                              // Required string.
        let affiliations = obj.affiliations?.components(separatedBy: "; ") ?? ["N/A"]              // Optional string.
        let authors = obj.authors?.components(separatedBy: ", ") ?? ["Unknown Author"]             // Optional string.
        let conflictOfInterest = obj.conflictOfInterest                                            // Optional string.
        let dateSaved = obj.dateSaved                                                              // Optional date.
        let doi = obj.doi ?? ""                                                                    // Optional string.
        let fullTextAvailable = obj.fullTextAvailable                                              // Required Bool.
        let funding = obj.funding?.components(separatedBy: "; ") ?? ["Not disclosed"]              // Optional string.
        let issue = obj.issue                                                                      // Optional string.
        let journal = obj.journal                                                                  // Optional string.
        let keywords = obj.keywords?.components(separatedBy: ", ") ?? ["None"]                     // Optional string.
        let meSHterms = obj.meSHterms?.components(separatedBy: ", ") ?? ["None"]                   // Optional string.
        let pages = obj.pages                                                                      // Optional string.
        let pmcid = obj.pmcid ?? ""                                                                // Optional string.
        let pmid = obj.pmid                                                                        // Required string.
        let pubDate = obj.pubDate                                                                  // Required date.
        let title = obj.title                                                                      // Required string.
        let volume = obj.volume                                                                    // Optional string.
        let webLink = obj.webLink                                                                  // Optional string.

        return PubMedArticle(
            abstract: abstract,                                                                    // Required string.
            affiliations: affiliations,                                                            // Optional string.
            authors: authors,                                                                      // Optional string.
            conflictOfInterest: conflictOfInterest,                                                // Optional string.
            dateSaved: dateSaved,                                                                  // Optional date.
            doi: doi,                                                                              // Optional string.
            fullTextAvailable: fullTextAvailable,                                                  // Required Bool.
            funding: funding,                                                                      // Optional string.
            issue: issue,                                                                          // Optional string.
            journal: journal,                                                                      // Optional string.
            keywords: keywords,                                                                    // Optional string.
            meSHterms: meSHterms,                                                                  // Optional string.
            pages: pages,                                                                          // Optional string.
            pmcid: pmcid,                                                                          // Optional string.
            pmid: pmid,                                                                            // Required string.
            pubDate: pubDate,                                                                      // Required date.
            title: title,                                                                          // Required string.
            volume: volume,                                                                        // Optional string.
            webLink: webLink                                                                       // Optional string.
        )
    }
}
