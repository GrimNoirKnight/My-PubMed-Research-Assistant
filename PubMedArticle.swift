//  PubMedArticle.swift
//  My PubMed Research Assistant
//
//  Description: Model representing a PubMed article with all metadata.
//  Version: 0.1.1-alpha (Added PMCID, DOI, Authors, MeSH Terms)

import Foundation

struct PubMedArticle: Codable, Identifiable {
    var id: String { pmid } // ✅ Uses PMID as unique ID
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
}
