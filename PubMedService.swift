//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Handles networking with the PubMed API.
//  Version: 0.3.8-alpha (Fixed Author Extraction & API Parsing)

import Foundation

class PubMedService {
    private let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&retmode=json&id="

    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        guard let url = URL(string: baseURL + query) else {
            throw URLError(.badURL)
        }

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20  // 20 seconds timeout
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
                pmid: detail.uid,
                pmcid: detail.pmcid,
                doi: detail.doi,
                title: detail.title,
                abstract: detail.abstract ?? "No abstract available",
                webLink: detail.webLink ?? "",
                authors: detail.authors?.compactMap { $0.name },  // ✅ Extracting author names correctly
                journal: detail.journal,  // ✅ Fixing source/journal issue
                pubDate: convertToDate(detail.pubdate),  // ✅ Fixing Date conversion
                volume: detail.volume,
                issue: detail.issue,
                pages: detail.pages,
                fullTextAvailable: false
            )
        }
    }

    /// ✅ Helper function to convert PubMed's `pubdate` string into a `Date?`
    private func convertToDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM" // PubMed uses "2024 Dec" format
        return formatter.date(from: dateString)
    }
}
