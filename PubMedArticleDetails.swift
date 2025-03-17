//  PubMedArticleDetails.swift
//  My PubMed Research Assistant
//
//  Description: Model for handling detailed PubMed article data from API response.
//  Version: 0.1.8-alpha (Fixed Decodable Conformance, Author Handling)

import Foundation

import Foundation

struct PubMedArticleDetails: Codable {
    let result: [String: PubMedArticleDetail]
}

struct PubMedArticleDetail: Codable {
    let pmid: String
    let pubdate: String?
    let journal: String?
    let title: String
    let volume: String?
    let issue: String?
    let pages: String?
    let authors: [Author]?
    let doi: String?
    let pmcid: String?
    
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
