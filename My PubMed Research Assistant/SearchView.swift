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

import SwiftUI

struct SearchView: View {
    @State private var searchQuery: String = "Myelin THC"
    @State private var isSearching = false
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSearching = false
        }
    }
}
