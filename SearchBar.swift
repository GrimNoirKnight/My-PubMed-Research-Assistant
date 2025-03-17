//  SearchBar.swift
//  My PubMed Research Assistant
//
//  Description: Custom Search Bar with a Magnifying Glass Icon
//  Version: 0.0.5-alpha

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass") // 🔍 Magnifying Glass Icon
                .foregroundColor(.gray)

            TextField("Search PubMed...", text: $text, onCommit: onSearch)
                .textFieldStyle(PlainTextFieldStyle())
                .disableAutocorrection(true)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill") // ❌ Clear Button
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
        .padding(.horizontal)
    }
}
