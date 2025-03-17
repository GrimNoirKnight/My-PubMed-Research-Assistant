//  PubMedArticleDetails.swift
//  My PubMed Research Assistant
//
//  Description: Model for handling detailed PubMed article data from API response.
//  Version: 0.1.5-alpha (Fixed Decodable Conformance, Author Handling)

import Foundation

import Foundation

struct PubMedArticleDetails: Codable {
    let result: [String: PubMedArticleDetail]
}

struct PubMedArticleDetail: Codable {
    let pmid: String  // ✅ Fixed from uid to pmid
    let pubdate: String?
    let journal: String?  // ✅ Renamed from source to journal
    let title: String
    let volume: String?
    let issue: String?
    let pages: String?
    let authors: [Author]?
    let doi: String?
    let pmcid: String?

    enum CodingKeys: String, CodingKey {
        case pmid = "uid"  // ✅ Fixed incorrect mapping
        case pubdate
        case journal = "source"  // ✅ Fixed incorrect mapping
        case title
        case volume
        case issue
        case pages
        case authors
        case doi
        case pmcid
    }

    struct Author: Codable {
        let name: String?
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
