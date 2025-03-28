<<<<<<< HEAD
<<<<<<< HEAD
//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: UI for searching PubMed articles and displaying results.
//  Version: 0.6.8-alpha (Fixed Hourglass & UIKit Constraints)
=======
//
//  SearchView.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


=======
>>>>>>> c76a8c2 (Backup before Core Data model change)
//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: Search screen and user entry point.
<<<<<<< HEAD
//  Version: 0.6.15-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)
=======
//  Version: 0.6.16-alpha
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)

import SwiftUI

struct SearchView: View {
<<<<<<< HEAD
    @State private var searchQuery = "Myelin THC"
=======
    @State private var searchQuery: String = "Myelin THC"
>>>>>>> cc80264 (Flattened directory structure using rsync)
    @State private var isSearching = false
    @State private var searchResults: [PubMedArticle] = []
    @State private var errorMessage: String?
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
<<<<<<< HEAD
<<<<<<< HEAD
        VStack {
            // Title
            Text("PubMed Search")
                .font(.title)
                .bold()
                .padding(.top, 10)

            // Search Bar
            HStack {
                TextField("Search PubMed", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(minHeight: 44) // ✅ Ensures minimum height to avoid layout conflicts
                    .focused($isTextFieldFocused)

                Button(action: {
                    performSearch()
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .padding(10)
                }
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
            }
            .padding(.horizontal)

            // Hourglass Indicator (Loading State)
            if isSearching {
                ProgressView("Searching...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }

            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .ignoresSafeArea(.keyboard, edges: .bottom) // ✅ Prevent keyboard overlap
        .onTapGesture {
            isTextFieldFocused = false // ✅ Dismiss keyboard when tapping outside
        }
    }

    // Function to Handle Search
    private func performSearch() {
        isSearching = true

        // Simulate search delay (replace with actual API call)
=======
        ScrollView {
=======
        NavigationStack {
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
            VStack(alignment: .leading, spacing: 16) {
                Text("PubMed Search")
                    .font(.title)
                    .bold()
                    .padding(.top, 10)

                HStack {
                    CleanTextField(
                        text: $searchQuery,
                        placeholder: "Search PubMed",
                        onCommit: {
                            performSearch()
                            isTextFieldFocused = false
                        }
                    )
                    .frame(height: 36)

                    Button(action: {
                        performSearch()
                        isTextFieldFocused = false
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .padding(10)
                    }
                    .background(Color(red: 0.235, green: 0.231, blue: 0.431))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                if isSearching {
                    ProgressView("Searching...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text("❌ \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if searchResults.isEmpty {
                    Text("No results found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(searchResults, id: \.pmid) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            VStack(alignment: .leading) {
                                Text(article.title)
                                    .font(.headline)
                                if let authors = article.authors {
                                    Text(authors.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }

                Spacer()
            }
            .padding()
            .onTapGesture { isTextFieldFocused = false }
            .background(Color.white)
            .foregroundColor(Color(red: 0.235, green: 0.231, blue: 0.431))
            .font(.custom("Arial", size: 12))
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }

    private func performSearch() {
        isSearching = true
<<<<<<< HEAD
>>>>>>> cc80264 (Flattened directory structure using rsync)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSearching = false
=======
        errorMessage = nil
        searchResults = []

        Task {
            do {
                let results = try await PubMedService().searchArticlesAsync(query: searchQuery)
                await MainActor.run {
                    self.searchResults = results
                    self.isSearching = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Search failed: \(error.localizedDescription)"
                    self.isSearching = false
                }
            }
>>>>>>> 2ce2e06 (chore: snapshot project tree 2025-03-27)
        }
    }
}
<<<<<<< HEAD

// Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
=======
>>>>>>> cc80264 (Flattened directory structure using rsync)
