//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: UI for searching PubMed articles and displaying results.
//  Version: 0.3.1-alpha (Optimized Fetch & UI Performance)

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = "Myelin THC"
    @State private var articles: [PubMedArticle] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    private let pubMedService = PubMedService()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText, onSearch: {
                    if searchText.trimmingCharacters(in: .whitespacesAndNewlines).count > 2 {
                        DispatchQueue.global(qos: .background).async {
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
                    List(articles.prefix(20)) { article in // Only load 20 items for performance
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

    @MainActor
    private func fetchArticles() async {
        guard !searchText.isEmpty else { return }
        isLoading = true
        errorMessage = nil

        do {
            let fetchedArticles = try await pubMedService.searchArticlesAsync(query: searchText)
            articles = fetchedArticles
            errorMessage = articles.isEmpty ? "No articles found." : nil
        } catch {
            errorMessage = "Search Error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
