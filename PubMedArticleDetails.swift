//  PubMedArticleDetails.swift
//  My PubMed Research Assistant
//
//  Description: Model for handling detailed PubMed article data from API response.
//  Version: 0.1.6-alpha (Fixed Decodable Conformance)

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
    let authors: [String]?
    let doi: String?
    let pmcid: String?
    let abstract: String?
    let webLink: String?

    enum CodingKeys: String, CodingKey {
        case pmid, pubdate, journal, title, volume, issue, pages, authors, doi, pmcid, abstract, webLink
    }
}
