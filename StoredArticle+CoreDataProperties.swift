<<<<<<< HEAD
//  StoredArticle.swift
//  My PubMed Research Assistant
//
//  Description: CoreData entity representing stored PubMed articles.
//  Version: 0.2.1-alpha (Fixed Duplicate Declarations, Added CloudKit Sync)
//

=======
//
//  StoredArticle+CoreDataProperties.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/23/25.
//
//

>>>>>>> cc80264 (Flattened directory structure using rsync)
import Foundation
import CoreData


extension StoredArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredArticle> {
        return NSFetchRequest<StoredArticle>(entityName: "StoredArticle")
    }

    @NSManaged public var abstract: String?
    @NSManaged public var affiliations: String?
    @NSManaged public var authors: String?
    @NSManaged public var conflictOfInterest: String?
    @NSManaged public var dateSaved: Date?
    @NSManaged public var doi: String?
    @NSManaged public var fullTextAvailable: String?
    @NSManaged public var funding: String?
    @NSManaged public var issue: String?
    @NSManaged public var journal: String?
    @NSManaged public var keywords: String?
    @NSManaged public var meSHterms: String?
<<<<<<< HEAD:StoredArticle.swift
    @NSManaged public var funding: String?
    @NSManaged public var conflictOfInterest: String?
    @NSManaged public var fullTextAvailable: Bool
    @NSManaged public var dateSaved: Date
<<<<<<< HEAD
}
=======
}
>>>>>>> cc80264 (Flattened directory structure using rsync)
=======
    @NSManaged public var pages: String?
    @NSManaged public var pmcid: String?
    @NSManaged public var pmid: String?
    @NSManaged public var pubDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var volume: String?
    @NSManaged public var weblink: String?

}

extension StoredArticle : Identifiable {

}
>>>>>>> c76a8c2 (Backup before Core Data model change):StoredArticle+CoreDataProperties.swift
