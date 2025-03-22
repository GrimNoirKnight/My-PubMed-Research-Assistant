//  PubMedArticleDetail.swift
//  My PubMed Research Assistant
//
<<<<<<< HEAD
//  Description: Handles detailed data parsing for PubMed API responses.
//  Version: 0.3.9-alpha (Fixed Missing Journal Field)
=======
//  Description: Detailed JSON model for parsing PubMed summary API response.
//  Version: 0.3.9-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)

import Foundation

struct PubMedArticleDetails: Codable {
    let result: [String: PubMedArticleDetail]
}

struct PubMedArticleDetail: Codable {
    let uid: String
    let pubdate: String?
<<<<<<< HEAD
    let journal: String?  // ✅ Fixed missing journal field
=======
    let journal: String?
>>>>>>> cc80264 (Flattened directory structure using rsync)
    let title: String
    let volume: String?
    let issue: String?
    let pages: String?
    let authors: [Author]?
    let doi: String?
    let pmcid: String?
    let abstract: String?
    let webLink: String?

<<<<<<< HEAD
    enum CodingKeys: String, CodingKey {
        case uid, pubdate, journal, title, volume, issue, pages, authors, doi, pmcid, abstract, webLink
    }

    struct Author: Codable {
        let name: String?
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        uid = try container.decode(String.self, forKey: .uid)
        pubdate = try? container.decode(String.self, forKey: .pubdate)
        journal = try? container.decode(String.self, forKey: .journal)  // ✅ Ensure journal is decoded
        title = try container.decode(String.self, forKey: .title)
        volume = try? container.decode(String.self, forKey: .volume)
        issue = try? container.decode(String.self, forKey: .issue)
        pages = try? container.decode(String.self, forKey: .pages)
        authors = try? container.decode([Author].self, forKey: .authors)
        doi = try? container.decode(String.self, forKey: .doi)
        pmcid = try? container.decode(String.self, forKey: .pmcid)
        abstract = try? container.decode(String.self, forKey: .abstract)
        webLink = try? container.decode(String.self, forKey: .webLink)
    }
=======
    struct Author: Codable {
        let name: String?
    }
>>>>>>> cc80264 (Flattened directory structure using rsync)
}
