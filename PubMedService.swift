//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Service handling API calls to fetch PubMed articles.
//  Version: 0.4.9-alpha (Improved Error Handling, Async/Await, JSON Decoding)

import Foundation

struct PubMedService {
    
    let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi"

    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        guard let url = URL(string: "\(baseURL)?db=pubmed&term=\(query)&retmode=json") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(PubMedArticleDetails.self, from: data)
        return decodedResponse.result.values.map { detail in
            PubMedArticle(
                pmid: detail.pmid,
                pmcid: detail.pmcid,
                doi: detail.doi,
                title: detail.title,
                abstract: detail.abstract ?? "No abstract available",
                webLink: detail.webLink ?? "",
                authors: detail.authors?.map { $0.name ?? "Unknown Author" },
                journal: detail.journal,
                pubDate: article.pubdate.flatMap { ISO8601DateFormatter().date(from: $0) },
                volume: detail.volume,
                issue: detail.issue,
                pages: detail.pages,
                fullTextAvailable: false
            )
        }
    }
    
    private func fetchArticleDetails(for pmid: String) async throws -> PubMedArticleDetail {
        guard let url = URL(string: "\(baseURL)?db=pubmed&id=\(pmid)&retmode=json") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decodedResponse = try JSONDecoder().decode(PubMedArticleDetails.self, from: data)
        guard let detail = decodedResponse.result[pmid] else {
            throw NSError(domain: "PubMedService", code: 2, userInfo: [NSLocalizedDescriptionKey: "No article details found"])
        }

        return detail
    }
}
