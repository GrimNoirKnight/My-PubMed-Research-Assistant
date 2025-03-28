<<<<<<< HEAD
<<<<<<< HEAD
//  StoredArticle.swift
//  My PubMed Research Assistant
//
//  Description: CoreData entity representing stored PubMed articles.
//  Version: 0.2.1-alpha (Fixed Duplicate Declarations, Added CloudKit Sync)
//

=======
//
=======
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
//  StoredArticle+CoreDataProperties.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on March 23, 2025.
//  © 2025 A. D. Keizer. All rights reserved.
//
//  Description:
//  This extension defines the properties of the `StoredArticle` Core Data entity.
//  It includes article metadata fetched from PubMed and saved by the user.
//
//  Version: 00.000.002-alpha
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

>>>>>>> cc80264 (Flattened directory structure using rsync)
import Foundation
import CoreData

extension StoredArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredArticle> {
        return NSFetchRequest<StoredArticle>(entityName: "StoredArticle")
    }

<<<<<<< HEAD
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

=======
    @NSManaged public var abstract: String                                                         // Required string.
    @NSManaged public var affiliations: String?                                                    // Optional string.
    @NSManaged public var authors: String?                                                         // Optional string.
    @NSManaged public var conflictOfInterest: String?                                              // Optional string.
    @NSManaged public var dateSaved: Date                                                          // Required date.
    @NSManaged public var doi: String?                                                             // Optional string.
    @NSManaged public var fullTextAvailable: Bool                                                  // Required Bool.
    @NSManaged public var funding: String?                                                         // Optional string.
    @NSManaged public var issue: String?                                                           // Optional string.
    @NSManaged public var journal: String?                                                         // Optional string.
    @NSManaged public var keywords: String?                                                        // Optional string.
    @NSManaged public var meSHterms: String?                                                       // Optional string.
    @NSManaged public var pages: String?                                                           // Optional string.
    @NSManaged public var pmcid: String?                                                           // Optional string.
    @NSManaged public var pmid: String                                                             // Required string.
    @NSManaged public var pubDate: Date?                                                           // Optional date.
    @NSManaged public var title: String                                                            // Required string.
    @NSManaged public var volume: String?                                                          // Optional string.
    @NSManaged public var webLink: String?                                                         // Optional string.
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
}

extension StoredArticle: Identifiable { }

<<<<<<< HEAD
}
>>>>>>> c76a8c2 (Backup before Core Data model change):StoredArticle+CoreDataProperties.swift
=======
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
