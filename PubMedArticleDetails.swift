//  PubMedArticleDetails.swift
//  My PubMed Research Assistant
//
//  Description: Model for handling detailed PubMed article data from API response.
//  Version: 0.1.6-alpha (Fixed Decodable Conformance, Author Handling)

import Foundation

import Foundation

struct PubMedArticleDetails: Codable {
    let result: [String: PubMedArticleDetail]
}

struct PubMedArticleDetail: Codable {
    let pmid: String
    let pubdate: String?
    let journal: String?  // ✅ Changed from `source`
    let title: String
    let volume: String?
    let issue: String?
    let pages: String?
    let authors: [Author]?
    let doi: String?
    let pmcid: String?
    let abstract: String? // ✅ Added
    let webLink: String? // ✅ Added

    enum CodingKeys: String, CodingKey {
        case pmid
        case pubdate
        case journal = "source" // ✅ Mapped from `source`
        case title
        case volume
        case issue
        case pages
        case authors
        case doi
        case pmcid
        case abstract // ✅ Mapped if missing
        case webLink // ✅ Mapped if missing
    }
}

// ✅ Define `ArticleID` struct to decode DOI, PMCID
struct ArticleID: Codable {
    let idtype: String
    let value: String
}

// ✅ Define `Author` struct correctly
struct Author: Codable {
    let name: String?
}
