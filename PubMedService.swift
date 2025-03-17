//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Service handling API calls to fetch PubMed articles.
//  Version: 0.4.6-alpha (Improved Error Handling, Async/Await, JSON Decoding)

import Foundation

struct PubMedService {
    let baseURL = "https://api.ncbi.nlm.nih.gov/lit/ctxp/v1/pubmed/?format=json&id="
    
    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        guard !query.isEmpty else { return [] }

        let endpoint = baseURL + query
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let response = try decoder.decode(PubMedArticleDetails.self, from: data)

        var articles: [PubMedArticle] = []

        for (_, detail) in response.result {
            let article = PubMedArticle(
                pmid: detail.pmid, // ✅ FIXED: Changed from uid to pmid
                pmcid: detail.pmcid,
                doi: detail.doi,
                title: detail.title,
                abstract: detail.abstract ?? "No abstract available",
                webLink: detail.webLink ?? "",
                authors: detail.authors?.map { $0.name ?? "Unknown" },
                journal: detail.journal, // ✅ FIXED: Changed from source to journal
                pubDate: convertDateStringToDate(detail.pubdate), // ✅ FIXED: Convert string to Date
                volume: detail.volume,
                issue: detail.issue,
                pages: detail.pages,
                fullTextAvailable: false
            )
            articles.append(article)
        }

        return articles
    }
}

// ✅ FIXED: Added date conversion function
func convertDateStringToDate(_ dateString: String?) -> Date? {
    guard let dateString = dateString else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MMM dd" // Adjust format as needed
    return formatter.date(from: dateString)
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
                    articles = fetchedArticleDetails.map { detail in
                        PubMedArticle(
                            pmid: detail.pmid,  // ✅ Changed from `uid`
                            pmcid: detail.pmcid,
                            doi: detail.doi,
                            title: detail.title,
                            abstract: detail.abstract ?? "No abstract available", // ✅ Added
                            webLink: detail.webLink ?? "", // ✅ Added
                            authors: detail.authors?.map { $0.name ?? "Unknown" },
                            journal: detail.journal,  // ✅ Changed from `source`
                            pubDate: detail.pubdate,
                            volume: detail.volume,
                            issue: detail.issue,
                            pages: detail.pages,
                            fullTextAvailable: false
                        )
                    }

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
