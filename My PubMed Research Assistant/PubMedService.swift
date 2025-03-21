//
//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Fetches article summaries from PubMed APIs.
//  Version: 0.3.9-alpha

import Foundation

class PubMedService {
    private let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&retmode=json&id="

    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        guard let url = URL(string: baseURL + query) else {
            throw URLError(.badURL)
        }

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.timeoutIntervalForResource = 30

        let (data, response) = try await URLSession(configuration: config).data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let result = try decoder.decode(PubMedArticleDetails.self, from: data)

        return result.result.values.map { detail in
            PubMedArticle(
                pmid: detail.uid,
                pmcid: detail.pmcid,
                doi: detail.doi,
                title: detail.title,
                abstract: detail.abstract ?? "",
                webLink: detail.webLink ?? "",
                authors: detail.authors?.compactMap { $0.name },
                journal: detail.journal,
                pubDate: convertToDate(detail.pubdate),
                volume: detail.volume,
                issue: detail.issue,
                pages: detail.pages,
                meSHterms: nil,
                funding: nil,
                conflictOfInterest: nil,
                fullTextAvailable: false
            )
        }
    }

    private func convertToDate(_ str: String?) -> Date? {
        guard let str = str else { return nil }
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy MMM"
        return fmt.date(from: str)
    }
}
