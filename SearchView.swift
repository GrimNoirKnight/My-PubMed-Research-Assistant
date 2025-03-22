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


//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: Search screen and user entry point.
//  Version: 0.6.15-alpha
>>>>>>> cc80264 (Flattened directory structure using rsync)

import SwiftUI

struct SearchView: View {
<<<<<<< HEAD
    @State private var searchQuery = "Myelin THC"
=======
    @State private var searchQuery: String = "Myelin THC"
>>>>>>> cc80264 (Flattened directory structure using rsync)
    @State private var isSearching = false
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
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
                }

                Spacer()
            }
            .padding()
            .onTapGesture { isTextFieldFocused = false }
        }
        .background(Color.white)
        .foregroundColor(Color(red: 0.235, green: 0.231, blue: 0.431))
        .font(.custom("Arial", size: 12))
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    private func performSearch() {
        isSearching = true
>>>>>>> cc80264 (Flattened directory structure using rsync)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSearching = false
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
