//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Service handling API calls to fetch PubMed articles.
//  Version: 0.4.4-alpha (Improved Error Handling, Async/Await, JSON Decoding)

import Foundation

class PubMedService {
    static let shared = PubMedService()
    private let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"

    private func fetchArticleDetails(articleID: String) async throws -> PubMedArticleDetail {
        let urlString = "\(baseURL)esummary.fcgi?db=pubmed&id=\(articleID)&retmode=json"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        // ✅ Print JSON response for debugging
        if let jsonString = String(data: data, encoding: .utf8) {
            print("📜 API Response for PMID \(articleID):\n\(jsonString)")
        }

        let decoder = JSONDecoder()

        do {
            let response = try decoder.decode(PubMedArticleDetails.self, from: data)
            
            // ✅ Extract article using dynamic key
            guard let article = response.result[articleID] else {
                throw NSError(domain: "PubMedService", code: 404, userInfo: [NSLocalizedDescriptionKey: "No article found for PMID \(articleID)"])
            }

            return article
        } catch {
            throw NSError(domain: "PubMedService", code: 500, userInfo: [NSLocalizedDescriptionKey: "JSON Decoding failed: \(error.localizedDescription)"])
        }
    }
}

extension PubMedService {
    @MainActor
    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        let searchURL = "\(baseURL)esearch.fcgi?db=pubmed&term=\(query)&retmode=json&retmax=20"
        guard let url = URL(string: searchURL) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        do {
            let searchResult = try decoder.decode(PubMedSearchResult.self, from: data)
            guard let idList = searchResult.esearchresult?.idlist, !idList.isEmpty else {
                throw NSError(domain: "PubMedService", code: 404, userInfo: [NSLocalizedDescriptionKey: "No articles found for query: \(query)"])
            }

            var articles: [PubMedArticle] = []

            for pmid in idList {
                do {
                    let detail = try await fetchArticleDetails(articleID: pmid)

                    // ✅ Convert PubMedArticleDetail → PubMedArticle
                    let article = PubMedArticle(
                        pmid: detail.uid,
                        pmcid: detail.pmcid,
                        doi: detail.doi,
                        title: detail.title,
                        abstract: detail.abstract ?? "No abstract available",
                        webLink: detail.webLink ?? "",
                        authors: detail.authors?.compactMap { $0.name },
                        journal: detail.source,
                        pubDate: nil, // Convert if needed
                        volume: detail.volume,
                        issue: detail.issue,
                        pages: detail.pages,
                        fullTextAvailable: false
                    )
                    
                    articles.append(article)
                } catch {
                    print("⚠️ Failed to fetch details for \(pmid): \(error.localizedDescription)")
                }
            }

            print("🟢 Retrieved \(articles.count) articles")
            return articles
        } catch {
            throw NSError(domain: "PubMedService", code: 500, userInfo: [NSLocalizedDescriptionKey: "JSON Decoding failed: \(error.localizedDescription)"])
        }
    }
}
