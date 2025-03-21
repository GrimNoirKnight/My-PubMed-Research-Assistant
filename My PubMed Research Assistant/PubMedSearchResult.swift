//  PubMedSearchResult.swift
//  My PubMed Research Assistant
//
//  Description: Model for initial PubMed search result IDs.
//  Version: 0.1.2-alpha

import Foundation

struct PubMedSearchResult: Codable {
    struct SearchResult: Codable {
        let idlist: [String]?
    }

    let esearchresult: SearchResult?
}
