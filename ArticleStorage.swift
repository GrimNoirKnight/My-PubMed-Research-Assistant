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
//  Description: Manages storing and retrieving PubMed articles from CoreData.
<<<<<<< HEAD
//  Version: 0.1.3-alpha (Added support for new attributes)
=======
//  Version: 0.1.3-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)

import Foundation
import CoreData

class ArticleStorage {
    static let shared = ArticleStorage()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PubMedData")
<<<<<<< HEAD

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("❌ CoreData Load Failed: \(error.localizedDescription)")
            } else {
                print("🟢 CoreData Store Loaded: \(storeDescription.url?.absoluteString ?? "Unknown Path")")
=======
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
    func saveArticles(_ articles: [PubMedArticle]) {
        let context = container.newBackgroundContext()
        context.perform {
            for article in articles {
                let fetch: NSFetchRequest<StoredArticle> = StoredArticle.fetchRequest()
                fetch.predicate = NSPredicate(format: "pmid == %@", article.pmid)

                do {
                    let results = try context.fetch(fetch)
                    let stored = results.first ?? StoredArticle(context: context)

                    stored.pmid = article.pmid
                    stored.pmcid = article.pmcid
                    stored.doi = article.doi
                    stored.title = article.title
                    stored.abstract = article.abstract
                    stored.webLink = article.webLink
                    stored.authors = article.authors?.joined(separator: ", ")
                    stored.affiliations = article.affiliations?.joined(separator: "; ")
                    stored.keywords = article.keywords?.joined(separator: ", ")
                    stored.journal = article.journal
                    stored.pubDate = article.pubDate
                    stored.volume = article.volume
                    stored.issue = article.issue
                    stored.pages = article.pages
                    stored.meSHterms = article.meSHterms?.joined(separator: ", ")
                    stored.funding = article.funding?.joined(separator: "; ")
                    stored.conflictOfInterest = article.conflictOfInterest
                    stored.fullTextAvailable = article.fullTextAvailable
                    stored.dateSaved = Date()
                } catch {
                    print("❌ Error fetching existing article: \(error)")
>>>>>>> cc80264 (Flattened directory structure using rsync)
                }
            }

            do {
                try context.save()
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
    func loadCachedArticles(for query: String) -> [PubMedArticle] {
        let context = container.viewContext
        let fetch: NSFetchRequest<StoredArticle> = StoredArticle.fetchRequest()

        do {
            let stored = try context.fetch(fetch)
            return stored.map { obj in
                PubMedArticle(
                    pmid: obj.pmid,
                    pmcid: obj.pmcid,
                    doi: obj.doi,
                    title: obj.title,
                    abstract: obj.abstract ?? "",
                    webLink: obj.webLink ?? "",
                    authors: obj.authors?.components(separatedBy: ", "),
                    affiliations: obj.affiliations?.components(separatedBy: "; "),
                    keywords: obj.keywords?.components(separatedBy: ", "),
                    journal: obj.journal,
                    pubDate: obj.pubDate,
                    volume: obj.volume,
                    issue: obj.issue,
                    pages: obj.pages,
                    meSHterms: obj.meSHterms?.components(separatedBy: ", "),
                    funding: obj.funding?.components(separatedBy: "; "),
                    conflictOfInterest: obj.conflictOfInterest,
                    fullTextAvailable: obj.fullTextAvailable
                )
            }
        } catch {
            print("❌ Load failed: \(error)")
>>>>>>> cc80264 (Flattened directory structure using rsync)
            return []
        }
    }
}
