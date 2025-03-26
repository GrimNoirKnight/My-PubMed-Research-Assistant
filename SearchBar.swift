<<<<<<< HEAD
<<<<<<< HEAD
//  SearchBar.swift
//  My PubMed Research Assistant
//
//  Description: Custom Search Bar with a Magnifying Glass Icon
=======
//
//  SearchBar.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


=======
>>>>>>> c76a8c2 (Backup before Core Data model change)
//  SearchBar.swift
//  My PubMed Research Assistant
//
//  Description: Custom SwiftUI search bar component.
>>>>>>> cc80264 (Flattened directory structure using rsync)
//  Version: 0.0.5-alpha

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
<<<<<<< HEAD
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
=======
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search PubMed...", text: $text, onCommit: onSearch)
                .disableAutocorrection(true)

            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
>>>>>>> cc80264 (Flattened directory structure using rsync)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
        .padding(.horizontal)
    }
}
