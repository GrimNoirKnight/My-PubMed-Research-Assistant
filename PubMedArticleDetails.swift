//  PubMedArticleDetails.swift
//  My PubMed Research Assistant
//
//  Description: Model for handling detailed PubMed article data from API response.
//  Version: 0.1.4-alpha (Fixed Decodable Conformance, Author Handling)

import Foundation

struct PubMedArticleDetails: Codable {
    let result: [String: PubMedArticleDetail]

    enum CodingKeys: String, CodingKey {
        case result
    }
}

struct PubMedArticleDetail: Codable {
    let uid: String
    let pubdate: String?
    let epubdate: String?
    let source: String?
    let title: String
    let volume: String?
    let issue: String?
    let pages: String?
    let authors: [Author]?
    let doi: String?
    let pmcid: String?

    enum CodingKeys: String, CodingKey {
        case uid, pubdate, epubdate, source, title, volume, issue, pages, authors, articleids
    }

    struct Author: Codable {
        let name: String?
    }

    struct ArticleID: Codable {
        let idtype: String
        let value: String
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        uid = try container.decode(String.self, forKey: .uid)
        pubdate = try? container.decode(String.self, forKey: .pubdate)
        epubdate = try? container.decode(String.self, forKey: .epubdate)
        source = try? container.decode(String.self, forKey: .source)
        title = try container.decode(String.self, forKey: .title)
        volume = try? container.decode(String.self, forKey: .volume)
        issue = try? container.decode(String.self, forKey: .issue)
        pages = try? container.decode(String.self, forKey: .pages)
        authors = try? container.decode([Author].self, forKey: .authors)

        // ✅ Decode article IDs and extract DOI & PMCID
        if let articleIDs = try? container.decode([ArticleID].self, forKey: .articleids) {
            doi = articleIDs.first { $0.idtype == "doi" }?.value
            pmcid = articleIDs.first { $0.idtype == "pmcid" }?.value
        } else {
            doi = nil
            pmcid = nil
        }
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
