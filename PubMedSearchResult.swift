//  PubMedSearchResult.swift
//  My PubMed Research Assistant
//
//  Description: Model for parsing PubMed search results.
//  Version: 0.1.2-alpha (Fixed Missing Struct)

import Foundation

struct PubMedSearchResult: Codable {
    struct SearchResult: Codable {
        let idlist: [String]?
    }
    
    let esearchresult: SearchResult?
}
