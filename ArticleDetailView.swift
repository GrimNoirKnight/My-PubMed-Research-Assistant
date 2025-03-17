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
                    .multilineTextAlignment(.leading)
                
                if let abstract = article.abstract, !abstract.isEmpty {
                    Text(abstract)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                } else {
                    Text("No abstract available")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray) // Optional: Different style for missing abstract
                }

                if let webLink = article.webLink, !webLink.isEmpty, let url = URL(string: webLink) {
                    Link("Read More", destination: url)
                        .font(.body)
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
