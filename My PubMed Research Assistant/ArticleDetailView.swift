//
//  ArticleDetailView.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


//  ArticleDetailView.swift
//  My PubMed Research Assistant
//
//  Description: View displaying details of a selected PubMed article.
//  Version: 0.0.3-alpha

import SwiftUI

struct ArticleDetailView: View {
    let article: PubMedArticle

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(article.title)
                    .font(.headline)

                if let abstract = article.abstract, !abstract.isEmpty {
                    Text(abstract)
                        .font(.body)
                } else {
                    Text("No abstract available")
                        .font(.body)
                        .foregroundColor(.gray)
                }

                if let webLink = article.webLink, let url = URL(string: webLink) {
                    Link("Read More", destination: url)
                        .foregroundColor(.blue)
                } else {
                    Text("No valid link available")
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Article Details")
    }
}
