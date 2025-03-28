<<<<<<< HEAD
<<<<<<< HEAD
//  PubMedArticle.swift
//  My PubMed Research Assistant
//
//  Description: Model representing a PubMed article with all metadata.
//  Version: 0.1.1-alpha (Added PMCID, DOI, Authors, MeSH Terms)
=======
//
//  PubMedArticle.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


=======
>>>>>>> c76a8c2 (Backup before Core Data model change)
//  PubMedArticle.swift
//  My PubMed Research Assistant
//
<<<<<<< HEAD
//  Description: Model representing a PubMed article.
//  Version: 0.1.1-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)

import Foundation

struct PubMedArticle: Codable, Identifiable {
<<<<<<< HEAD
    var id: String { pmid } // ✅ Uses PMID as unique ID
=======
    var id: String { pmid }

>>>>>>> cc80264 (Flattened directory structure using rsync)
    var pmid: String
    var pmcid: String?
    var doi: String?
    var title: String
    var abstract: String?
    var webLink: String?
    var authors: [String]?
    var affiliations: [String]?
    var keywords: [String]?
    var journal: String?
    var pubDate: Date?
    var volume: String?
    var issue: String?
    var pages: String?
    var meSHterms: [String]?
    var funding: [String]?
    var conflictOfInterest: String?
    var fullTextAvailable: Bool
<<<<<<< HEAD

    enum CodingKeys: String, CodingKey {
        case pmid
        case pmcid
        case doi
        case title
        case abstract
        case webLink
        case authors
        case affiliations
        case keywords
        case journal
        case pubDate
        case volume
        case issue
        case pages
        case meSHterms
        case funding
        case conflictOfInterest
        case fullTextAvailable
    }
=======
>>>>>>> cc80264 (Flattened directory structure using rsync)
=======
//  Created by Alan D. Keizer
//  © 2025 A. D. Keizer. All rights reserved.
//
//  Description:
//  Struct representing a PubMed article in memory.
//  Used for decoding, displaying, and saving to Core Data.
//
//  Version: 00.001.003-alpha
//
//  Attribute Name          Type      Optional        Notes
//  -----------------------+---------+---------------+-----------------------------------------------
//  abstract                String    No              Abstract text
//  affiliations            String    Yes             Author affiliations
//  authors                 String    Yes             List of authors (comma-separated)
//  conflictOfInterest      String    Yes             Conflict of interest statement
//  dateSaved               Date      No              When article was saved
//  doi                     String    Yes             Digital Object Identifier
//  fullTextAvailable       Boolean   No              True/False flag
//  funding                 String    Yes             Funding sources
//  issue                   String    Yes             Issue number
//  journal                 String    Yes             Journal name
//  keywords                String    Yes             Keywords (comma-separated)
//  meSHterms               String    Yes             Medical Subject Headings (comma-separated)
//  pages                   String    Yes             Page numbers
//  pmcid                   String    Yes             Optional identifier
//  pmid                    String    No              Primary identifier
//  pubDate                 Date      Yes             Publication date
//  title                   String    No              Article title
//  volume                  String    Yes             Volume number
//  webLink                 String    Yes             Link to article

import Foundation

struct PubMedArticle {
    // MARK: - Attributes (Alphabetically Sorted)

    var abstract: String                                                                         // Required
    var affiliations: [String]?                                                                  // Optional
    var authors: [String]?                                                                       // Optional
    var conflictOfInterest: String?                                                              // Optional
    var dateSaved: Date                                                                          // Required
    var doi: String?                                                                             // Optional
    var fullTextAvailable: Bool                                                                  // Required
    var funding: [String]?                                                                       // Optional
    var issue: String?                                                                           // Optional
    var journal: String?                                                                         // Optional
    var keywords: [String]?                                                                      // Optional
    var meSHterms: [String]?                                                                     // Optional
    var pages: String?                                                                           // Optional
    var pmcid: String?                                                                           // Optional
    var pmid: String                                                                             // Required
    var pubDate: Date?                                                                           // Optional
    var title: String                                                                            // Required
    var volume: String?                                                                          // Optional
    var webLink: String?                                                                         // Optional
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
}
