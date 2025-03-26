<<<<<<< HEAD
<<<<<<< HEAD
//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Handles networking with the PubMed API.
//  Version: 0.3.9-alpha (Fixed Journal Field)
=======
//
//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


=======
>>>>>>> c76a8c2 (Backup before Core Data model change)
//  PubMedService.swift
//  My PubMed Research Assistant
//
//  Description: Fetches article summaries from PubMed APIs.
//  Version: 0.3.9-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)

import Foundation

class PubMedService {
    private let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&retmode=json&id="

    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        guard let url = URL(string: baseURL + query) else {
            throw URLError(.badURL)
        }

<<<<<<< HEAD
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20  // 20 seconds timeout
        sessionConfig.timeoutIntervalForResource = 30

        let session = URLSession(configuration: sessionConfig)
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
=======
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.timeoutIntervalForResource = 30

        let (data, response) = try await URLSession(configuration: config).data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
>>>>>>> cc80264 (Flattened directory structure using rsync)
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
<<<<<<< HEAD
        let decodedResponse = try decoder.decode(PubMedArticleDetails.self, from: data)

        return decodedResponse.result.values.map { detail in
=======

        let result = try decoder.decode(PubMedArticleDetails.self, from: data)

        return result.result.values.map { detail in
>>>>>>> cc80264 (Flattened directory structure using rsync)
            PubMedArticle(
                pmid: detail.uid,
                pmcid: detail.pmcid,
                doi: detail.doi,
                title: detail.title,
<<<<<<< HEAD
                abstract: detail.abstract ?? "No abstract available",
                webLink: detail.webLink ?? "",
                authors: detail.authors?.compactMap { $0.name },  // ✅ Extracting author names correctly
                journal: detail.journal,  // ✅ Now correctly mapped
                pubDate: convertToDate(detail.pubdate),  // ✅ Fixing Date conversion
                volume: detail.volume,
                issue: detail.issue,
                pages: detail.pages,
=======
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
>>>>>>> cc80264 (Flattened directory structure using rsync)
                fullTextAvailable: false
            )
        }
    }

<<<<<<< HEAD
    /// ✅ Helper function to convert PubMed's `pubdate` string into a `Date?`
    private func convertToDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM" // PubMed uses "2024 Dec" format
        return formatter.date(from: dateString)
=======
    private func convertToDate(_ str: String?) -> Date? {
        guard let str = str else { return nil }
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy MMM"
        return fmt.date(from: str)
>>>>>>> cc80264 (Flattened directory structure using rsync)
    }
}
