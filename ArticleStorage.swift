//  ArticleStorage.swift
//  My PubMed Research Assistant
//
//  Description: Manages storing and retrieving PubMed articles from CoreData.
//  Version: 0.1.3-alpha (Added support for new attributes)

import Foundation
import CoreData

class ArticleStorage {
    static let shared = ArticleStorage()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PubMedData")

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("❌ CoreData Load Failed: \(error.localizedDescription)")
            } else {
                print("🟢 CoreData Store Loaded: \(storeDescription.url?.absoluteString ?? "Unknown Path")")
            }
        }
    }

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
                }
            }

            do {
                try context.save()
                print("🟢 Articles saved to CoreData.")
            } catch {
                print("❌ Failed to save articles: \(error.localizedDescription)")
            }
        }
    }

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
            return []
        }
    }
}
