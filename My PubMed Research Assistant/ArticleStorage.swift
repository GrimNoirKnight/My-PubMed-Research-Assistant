//
//  ArticleStorage.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


//  ArticleStorage.swift
//  My PubMed Research Assistant
//
//  Description: Manages storing and retrieving PubMed articles from CoreData.
//  Version: 0.1.3-alpha

import Foundation
import CoreData

class ArticleStorage {
    static let shared = ArticleStorage()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PubMedData")
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("❌ CoreData Load Failed: \(error.localizedDescription)")
            } else {
                print("🟢 CoreData Store Loaded: \(desc.url?.absoluteString ?? "Unknown")")
            }
        }
    }

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
                }
            }

            do {
                try context.save()
                print("🟢 Articles saved to CoreData.")
            } catch {
                print("❌ Failed to save articles: \(error)")
            }
        }
    }

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
            return []
        }
    }
}
