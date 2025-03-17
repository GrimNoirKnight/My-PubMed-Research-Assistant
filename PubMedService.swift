//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Handles networking with the PubMed API.
//  Version: 0.3.1-alpha (Fixed API timeouts & decoding issues)

import Foundation

class PubMedService {
    private let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&retmode=json&id="

    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        guard let url = URL(string: baseURL + query) else {
            throw URLError(.badURL)
        }

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15 // Extended timeout
        sessionConfig.timeoutIntervalForResource = 30
        let session = URLSession(configuration: sessionConfig)

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try decoder.decode(PubMedArticleDetails.self, from: data)

        return decodedResponse.result.values.map { detail in
            PubMedArticle(
                pmid: detail.pmid,
                pmcid: detail.pmcid,
                doi: detail.doi,
                title: detail.title,
                abstract: detail.abstract ?? "No abstract available",
                webLink: detail.webLink ?? "",
                authors: detail.authors,
                journal: detail.journal,
                pubDate: detail.pubdate,
                volume: detail.volume,
                issue: detail.issue,
                pages: detail.pages,
                fullTextAvailable: false
            )
        }
    }
}
