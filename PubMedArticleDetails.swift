//  PubMedArticleDetails.swift
//  My PubMed Research Assistant
//
//  Description: Model for handling detailed PubMed article data from API response.
//  Version: 0.1.8-alpha (Fixed Missing Fields: Abstract & WebLink)

import Foundation

struct PubMedArticleDetails: Codable {
    let result: [String: PubMedArticleDetail]
}

struct PubMedArticleDetail: Codable {
    let uid: String
    let pubdate: String?
    let source: String?
    let title: String
    let volume: String?
    let issue: String?
    let pages: String?
    let authors: [Author]?
    let doi: String?
    let pmcid: String?
    let abstract: String?  // ✅ FIXED: Added missing `abstract`
    let webLink: String?   // ✅ FIXED: Added missing `webLink`

    enum CodingKeys: String, CodingKey {
        case uid, pubdate, source, title, volume, issue, pages, authors, doi, pmcid, abstract, webLink
    }

    struct Author: Codable {
        let name: String
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        uid = try container.decode(String.self, forKey: .uid)
        pubdate = try? container.decode(String.self, forKey: .pubdate)
        source = try? container.decode(String.self, forKey: .source)
        title = try container.decode(String.self, forKey: .title)
        volume = try? container.decode(String.self, forKey: .volume)
        issue = try? container.decode(String.self, forKey: .issue)
        pages = try? container.decode(String.self, forKey: .pages)
        authors = try? container.decode([Author].self, forKey: .authors)
        doi = try? container.decode(String.self, forKey: .doi)
        pmcid = try? container.decode(String.self, forKey: .pmcid)
        abstract = try? container.decode(String.self, forKey: .abstract)  // ✅ Fixed: Ensure decoding of `abstract`
        webLink = try? container.decode(String.self, forKey: .webLink)    // ✅ Fixed: Ensure decoding of `webLink`
    }
}
