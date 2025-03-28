//  PubMedArticleDetail.swift
//  My PubMed Research Assistant
//
<<<<<<< HEAD
//  Description: Handles detailed data parsing for PubMed API responses.
//  Version: 0.3.9-alpha (Fixed Missing Journal Field)
=======
//  Description: Detailed JSON model for parsing PubMed summary API response.
<<<<<<< HEAD
//  Version: 0.3.9-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)
=======
//  Version: 0.4.0-alpha
//
//  Refactored: Attributes alphabetized, uid renamed to pmid, and Codable key handling stabilized.
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)

import Foundation

// Allow UID to be String or Int
enum StringOrInt: Codable {
    case string(String)
    case int(Int)

    var stringValue: String {
        switch self {
        case .string(let str): return str
        case .int(let val): return String(val)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intVal = try? container.decode(Int.self) {
            self = .int(intVal)
        } else if let strVal = try? container.decode(String.self) {
            self = .string(strVal)
        } else {
            throw DecodingError.typeMismatch(
                StringOrInt.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Not a String or Int")
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let val): try container.encode(val)
        case .string(let val): try container.encode(val)
        }
    }
}

struct PubMedArticleDetails: Codable {
    let result: [String: PubMedArticleDetail]
}

struct PubMedArticleDetail: Codable {
<<<<<<< HEAD
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
=======
    let abstract: String?
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
    let authors: [Author]?
    let doi: String?
    let issue: String?
    let journal: String?
    let pages: String?
    let pmcid: String?
    let pmid: StringOrInt
    let pubdate: String?
    let title: String
    let volume: String?
    let webLink: String?

<<<<<<< HEAD
    enum CodingKeys: String, CodingKey {
        case uid, pubdate, journal, title, volume, issue, pages, authors, doi, pmcid, abstract, webLink
    }

    struct Author: Codable {
        let name: String?
    }

<<<<<<< HEAD
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
=======
    enum CodingKeys: String, CodingKey {
        case abstract, authors, doi, issue, journal, pages, pmcid, pmid = "uid", pubdate, title, volume, webLink
    }
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
}
