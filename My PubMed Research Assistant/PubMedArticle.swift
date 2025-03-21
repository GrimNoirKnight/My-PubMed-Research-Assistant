//
//  PubMedArticle.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


//  PubMedArticle.swift
//  My PubMed Research Assistant
//
//  Description: Model representing a PubMed article.
//  Version: 0.1.1-alpha

import Foundation

struct PubMedArticle: Codable, Identifiable {
    var id: String { pmid }

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
}
