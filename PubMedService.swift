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
<<<<<<< HEAD
//  Description: Fetches article summaries from PubMed APIs.
//  Version: 0.3.9-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)
=======
//  Created by Alan D. Keizer
//  © 2025 A. D. Keizer. All rights reserved.
//
//  Description:
//  Fetches article summaries from PubMed APIs.
//  Converts raw API results into structured PubMedArticle structs.
//
//  Version: 00.003.014-alpha
//
//  Change Log:
//  - Fixed decoding bug: replaced deprecated `uid` with `pmid` (decoded from JSON "uid")
//  - All article identifiers now consistently handled using `StringOrInt`
//  - Ensured stable decoding and formatting for robust parsing
//
// Attribute Name          Type      Optional        Notes
// -----------------------+---------+---------------+-----------------------------------------------
// abstract                String    No              Abstract text
// affiliations            String    Yes             Author affiliations
// authors                 String    Yes             List of authors (comma-separated)
// conflictOfInterest      String    Yes             Conflict of interest statement
// dateSaved               Date      No              When article was saved
// doi                     String    Yes             Digital Object Identifier
// fullTextAvailable       Boolean   No              True/False flag
// funding                 String    Yes             Funding sources
// issue                   String    Yes             Issue number
// journal                 String    Yes             Journal name
// keywords                String    Yes             Keywords (comma-separated)
// meSHterms               String    Yes             Medical Subject Headings (comma-separated)
// pages                   String    Yes             Page numbers
// pmcid                   String    Yes             Optional identifier
// pmid                    String    No              Primary identifier
// pubDate                 Date      Yes             Publication date
// title                   String    No              Article title
// volume                  String    Yes             Volume number
// webLink                 String    Yes             Link to article
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)

import Foundation

class PubMedService {
    private let searchBaseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&term="
    private let summaryBaseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&retmode=json&id="

    // Retry-capable fetch for resilience
    private func fetchData(from url: URL, retries: Int = 3) async throws -> (Data, URLResponse) {
        for attempt in 1...retries {
            do {
                print("🌐 Attempt \(attempt): Fetching \(url.absoluteString)")
                let (data, response) = try await URLSession.shared.data(from: url)
                return (data, response)
            } catch {
                print("⚠️ Attempt \(attempt) failed: \(error.localizedDescription)")
                if attempt == retries { throw error }
                try await Task.sleep(nanoseconds: 500_000_000) // Wait 0.5s before retry
            }
        }
        throw URLError(.cannotLoadFromNetwork)
    }

    // Asynchronous article search + summary fetch
    func searchArticlesAsync(query: String) async throws -> [PubMedArticle] {
        // STEP 1: Search article IDs
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let searchURL = URL(string: searchBaseURL + encodedQuery) else {
            throw URLError(.badURL)
        }

<<<<<<< HEAD
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
=======
        let (searchData, searchResponse) = try await fetchData(from: searchURL)
        guard (searchResponse as? HTTPURLResponse)?.statusCode == 200 else {
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
            throw URLError(.badServerResponse)
        }

        print("✅ Search completed")
        let idResult = try JSONDecoder().decode(PubMedSearchResult.self, from: searchData)
        guard let ids = idResult.esearchresult?.idlist, !ids.isEmpty else {
            print("⚠️ No article IDs found.")
            return []
        }

        // STEP 2: Fetch summary details
        let idString = ids.joined(separator: ",")
        guard let summaryURL = URL(string: summaryBaseURL + idString) else {
            throw URLError(.badURL)
        }

        let (summaryData, summaryResponse) = try await fetchData(from: summaryURL)
        guard (summaryResponse as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        print("✅ Summary data fetched")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
<<<<<<< HEAD
<<<<<<< HEAD
        let decodedResponse = try decoder.decode(PubMedArticleDetails.self, from: data)

        return decodedResponse.result.values.map { detail in
=======
=======
        let result = try decoder.decode(PubMedArticleDetails.self, from: summaryData)
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)

        // STEP 3: Convert result map to PubMedArticle structs
        let validArticles = ids.compactMap { id -> PubMedArticle? in
            guard let detail = result.result[id] else { return nil }

<<<<<<< HEAD
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
=======
            return PubMedArticle(
                abstract: detail.abstract ?? "",                                                    // Required string
                affiliations: nil,                                                                  // Optional string
                authors: detail.authors?.compactMap { $0.name },                                    // Optional string
                conflictOfInterest: nil,                                                            // Optional string
                dateSaved: Date(),                                                                  // Required date
                doi: detail.doi,                                                                    // Optional string
                fullTextAvailable: false,                                                           // Required Bool
                funding: nil,                                                                       // Optional string
                issue: detail.issue,                                                                // Optional string
                journal: detail.journal,                                                            // Optional string
                keywords: nil,                                                                      // Optional string
                meSHterms: nil,                                                                     // Optional string
                pages: detail.pages,                                                                // Optional string
                pmcid: detail.pmcid,                                                                // Optional string
                pmid: detail.pmid.stringValue,                                                      // ✅ Corrected reference
                pubDate: convertToDate(detail.pubdate),                                             // Optional date
                title: detail.title,                                                                // Required string
                volume: detail.volume,                                                              // Optional string
                webLink: detail.webLink                                                             // Optional string
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
            )
        }

        return validArticles
    }

<<<<<<< HEAD
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
=======
    // Converts string like "2024 Mar" to Date
    private func convertToDate(_ str: String?) -> Date? {
        guard let str = str else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM"
        return formatter.date(from: str)
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
    }
}
