//  PubMedSearchResult.swift
//  My PubMed Research Assistant
//
<<<<<<< HEAD
//  Description: Model for parsing PubMed search results.
//  Version: 0.1.2-alpha (Fixed Missing Struct)
=======
//  Description: Model for initial PubMed search result IDs.
//  Version: 0.1.2-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)

import Foundation

struct PubMedSearchResult: Codable {
    struct SearchResult: Codable {
        let idlist: [String]?
    }
<<<<<<< HEAD
    
=======

>>>>>>> cc80264 (Flattened directory structure using rsync)
    let esearchresult: SearchResult?
}
