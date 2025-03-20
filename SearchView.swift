//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: UI for searching PubMed articles and displaying results.
//  Version: 0.6.8-alpha (Fixed Hourglass & UIKit Constraints)

import SwiftUI

struct SearchView: View {
    @State private var searchQuery = "Myelin THC"
    @State private var isSearching = false
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSearching = false
        }
    }
}

// Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
