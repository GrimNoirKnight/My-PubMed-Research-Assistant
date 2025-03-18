//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: UI for searching PubMed articles and displaying results.
//  Version: 0.6.4-alpha (Fixed UIKit Constraint Override)

import SwiftUI

struct SearchView: View {
    @State private var searchQuery = "Myelin THC" // ✅ Default search term restored
    @State private var isLoading = false          // ✅ Loading state for hourglass
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        NavigationView {
            VStack {
                // ✅ Search Field
                TextField("Search PubMed", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        performSearch()
                    }

                // ✅ Loading Indicator (Hourglass)
                if isLoading {
                    ProgressView("Searching…")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }

                // ✅ Placeholder for Search Results (Replace with actual list)
                Spacer()
                Text("Search results will appear here.")
                    .foregroundColor(.gray)

            }
            .padding()
            .navigationTitle("Search PubMed") // ✅ Restored missing title
            .onAppear {
                fixKeyboardConstraints()
            }
        }
    }

    /// ✅ Simulated search function with delay
    private func performSearch() {
        isLoading = true
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
            isLoading = false
        }
    }

    /// ✅ Fix UIKit Keyboard Constraints (Prevents breaking layout)
    private func fixKeyboardConstraints() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIApplication.shared.windows.first?.rootViewController?.view.setNeedsLayout()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
