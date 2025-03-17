//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: UI for searching PubMed articles and displaying results.
//  Version: 0.5.0-alpha (Final Fix for UIKit Keyboard Constraints)

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = "Myelin THC"
    @State private var articles: [PubMedArticle] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @FocusState private var isSearchFieldFocused: Bool // ✅ Focus control for keyboard

    private let pubMedService = PubMedService()

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText, onSearch: {
                    if searchText.trimmingCharacters(in: .whitespacesAndNewlines).count > 2 {
                        Task {
                            await fetchArticles()
                        }
                    }
                })
                .focused($isSearchFieldFocused)
                .keyboardType(.default)
                .onAppear {
                    isSearchFieldFocused = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        suppressKeyboardConflicts() // ✅ Stronger suppression
                    }
                }
                .onDisappear {
                    dismissKeyboard()
                }

                if isLoading {
                    ProgressView("Searching...").padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage).foregroundColor(.red).padding()
                } else if articles.isEmpty {
                    Text("No articles found.").foregroundColor(.gray).padding()
                } else {
                    List(articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            VStack(alignment: .leading) {
                                Text(article.title).font(.headline)
                                Text(article.abstract ?? "No abstract available.")
                                    .font(.subheadline)
                                    .lineLimit(2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)
                }
            }
            .navigationTitle("PubMed Search")
            .ignoresSafeArea(.keyboard, edges: .bottom) // ✅ Prevents UIKit from forcing constraints
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

    /// ✅ Dismisses the keyboard programmatically
    private func dismissKeyboard() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    /// ✅ Completely suppresses keyboard conflicts by force-removing UIKit constraints
    private func suppressKeyboardConflicts() {
        DispatchQueue.main.async {
            for window in UIApplication.shared.windows {
                if let rootView = window.rootViewController?.view {
                    for subview in rootView.subviews {
                        if subview.description.contains("InputAssistantView") ||
                            subview.description.contains("InputAccessoryView") ||
                            subview.description.contains("UIRemoteKeyboardPlaceholderView") {
                            subview.removeFromSuperview() // ✅ Force remove UIKit views
                        }
                    }
                }
            }
        }
    }
}
