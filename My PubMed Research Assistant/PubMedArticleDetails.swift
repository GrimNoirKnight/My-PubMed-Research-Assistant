//  PubMedArticleDetail.swift
//  My PubMed Research Assistant
//
//  Description: Detailed JSON model for parsing PubMed summary API response.
//  Version: 0.3.9-alpha

import Foundation

struct PubMedArticleDetails: Codable {
    let result: [String: PubMedArticleDetail]
}

struct PubMedArticleDetail: Codable {
    let uid: String
    let pubdate: String?
    let journal: String?
    let title: String
    let volume: String?
    let issue: String?
    let pages: String?
    let authors: [Author]?
    let doi: String?
    let pmcid: String?
    let abstract: String?
    let webLink: String?

    struct Author: Codable {
        let name: String?
    }
}
