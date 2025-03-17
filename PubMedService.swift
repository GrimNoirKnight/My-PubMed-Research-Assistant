//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Handles fetching and processing PubMed article data.
//  Version: 0.3.1-alpha (Fixed API mapping and function errors)

import Foundation

class PubMedService {
    
    private let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi"
    private let apiKey = "YOUR_API_KEY" // Replace with a valid API key if required

    /// Searches PubMed articles asynchronously using a given query.
    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        guard let url = URL(string: "\(baseURL)?db=pubmed&term=\(query)&retmode=json&api_key=\(apiKey)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(PubMedArticleDetails.self, from: data)
        
        let articles = decodedResponse.result.values.map { detail in
            PubMedArticle(
                pmid: detail.pmid,
                pmcid: detail.pmcid,
                doi: detail.doi,
                title: detail.title,
                abstract: detail.abstract ?? "No abstract available",
                webLink: detail.webLink ?? "",
                authors: detail.authors?.map { $0.name ?? "Unknown" },
                journal: detail.journal ?? "Unknown Journal",
                pubDate: detail.pubdate,
                volume: detail.volume,
                issue: detail.issue,
                pages: detail.pages,
                fullTextAvailable: false
            )
        }
        
        return articles
    }
}
