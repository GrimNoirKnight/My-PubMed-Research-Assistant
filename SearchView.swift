//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: UI for searching PubMed articles and displaying results.
//  Version: 0.2.7-alpha (Fixed Infinite Searching & Abstract Display)

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = "Myelin THC"
    @State private var articles: [PubMedArticle] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @State private var lastSearchText: String = ""
    @State private var debounceTimer: Timer?
    
    private let pubMedService = PubMedService()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText, onSearch: {
                    debounceTimer?.invalidate()
                    debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).count > 2, searchText != lastSearchText {
                            lastSearchText = searchText
                            Task {
                                await fetchArticles()
                            }
                        }
                    }
                })
                
                if isLoading {
                    ProgressView("Searching...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if articles.isEmpty {
                    Text("No articles found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            VStack(alignment: .leading) {
                                Text(article.title)
                                    .font(.headline)
                                Text(article.abstract ?? "No abstract available.")
                                    .font(.subheadline)
                                    .lineLimit(2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("PubMed Search")
        }
    }

    // ✅ Fixed function
    @MainActor
    private func fetchArticles() async {
        guard !searchText.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            let fetchedArticleDetails = try await pubMedService.searchArticlesAsync(query: searchText)

            articles = fetchedArticleDetails.map { detail in
                PubMedArticle(
                    pmid: detail.pmid,  // ✅ FIXED: Changed from uid to pmid
                    pmcid: detail.pmcid,
                    doi: detail.doi,
                    title: detail.title,
                    abstract: detail.abstract ?? "No abstract available",
                    webLink: detail.webLink ?? "",
                    authors: detail.authors,  // ✅ FIXED: No need to map `.name`
                    affiliations: nil,
                    keywords: nil,
                    journal: detail.journal,  // ✅ FIXED: Changed from source to journal
                    pubDate: nil,
                    volume: detail.volume,
                    issue: detail.issue,
                    pages: detail.pages,
                    meSHterms: nil,
                    funding: nil,
                    conflictOfInterest: nil,
                    fullTextAvailable: false
                )
            }

            errorMessage = articles.isEmpty ? "No articles found." : nil
        } catch {
            errorMessage = "Search Error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
