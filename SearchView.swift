//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: UI for searching PubMed articles and displaying results.
//  Version: 0.6.2-alpha (Fixed UIKit Constraint Override)

import SwiftUI
import UIKit

struct SearchView: View {
    @State private var searchText: String = "Myelin THC"
    @State private var articles: [PubMedArticle] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @FocusState private var isSearchFieldFocused: Bool

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
                    enforceSafeKeyboardHandling() // ✅ Final UIKit fix
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
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .onAppear {
            enforceSafeKeyboardHandling() // ✅ Ensures UIKit does not reapply constraints
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

    /// ✅ **Final Override of UIKit Constraint Handling**
    private func enforceSafeKeyboardHandling() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let window = UIApplication.shared.windows.first else { return }
            let systemViews = ["UIRemoteKeyboardPlaceholderView", "InputAssistantView", "InputAccessoryView"]

            // ✅ Remove any lingering system views
            for view in window.subviews {
                if systemViews.contains(where: { view.description.contains($0) }) {
                    view.removeFromSuperview()
                }
            }

            // ✅ Force UIKit to release broken constraints
            for constraint in window.constraints {
                if let firstItem = constraint.firstItem, let secondItem = constraint.secondItem {
                    let firstName = String(describing: firstItem)
                    let secondName = String(describing: secondItem)
                    
                    if systemViews.contains(where: { firstName.contains($0) }) ||
                        systemViews.contains(where: { secondName.contains($0) }) {
                        window.removeConstraint(constraint)
                    }
                }
            }
        }
    }
} // ✅ **Closing brace for `SearchView`**
