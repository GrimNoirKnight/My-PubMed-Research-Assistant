//
//  StoredArticle.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


//  StoredArticle.swift
//  My PubMed Research Assistant
//
//  Description: CoreData representation of PubMed article.
//  Version: 0.2.1-alpha

import Foundation
import CoreData

@objc(StoredArticle)
public class StoredArticle: NSManagedObject {}

extension StoredArticle {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredArticle> {
        return NSFetchRequest<StoredArticle>(entityName: "StoredArticle")
    }

    @NSManaged public var pmid: String
    @NSManaged public var pmcid: String?
    @NSManaged public var doi: String?
    @NSManaged public var title: String
    @NSManaged public var abstract: String?
    @NSManaged public var webLink: String?
    @NSManaged public var authors: String?
    @NSManaged public var affiliations: String?
    @NSManaged public var journal: String?
    @NSManaged public var keywords: String?
    @NSManaged public var pubDate: Date?
    @NSManaged public var volume: String?
    @NSManaged public var issue: String?
    @NSManaged public var pages: String?
    @NSManaged public var meSHterms: String?
    @NSManaged public var funding: String?
    @NSManaged public var conflictOfInterest: String?
    @NSManaged public var fullTextAvailable: Bool
    @NSManaged public var dateSaved: Date
}