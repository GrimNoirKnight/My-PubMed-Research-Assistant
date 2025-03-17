//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Handles fetching and processing PubMed article data.
//  Version: 0.3.2-alpha (Fixed Date Conversion)

import Foundation

class PubMedService {
    
    private let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi"
    private let apiKey = "YOUR_API_KEY" // Replace with a valid API key if required
    
    /// Date formatter for converting pubdate strings to Date objects
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM dd"  // Adjust based on actual API format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

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
                pubDate: convertDateString(detail.pubdate),  // ✅ FIXED: Proper Date Conversion
                volume: detail.volume,
                issue: detail.issue,
                pages: detail.pages,
                fullTextAvailable: false
            )
        }
        
        return articles
    }

    /// Converts a date string to a `Date?` using the formatter
    private func convertDateString(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        return dateFormatter.date(from: dateString)
    }
}


