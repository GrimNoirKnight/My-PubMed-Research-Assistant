<<<<<<< HEAD
=======
//
//  ArticleDetailView.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


>>>>>>> cc80264 (Flattened directory structure using rsync)
//  ArticleDetailView.swift
//  My PubMed Research Assistant
//
//  Description: View displaying details of a selected PubMed article.
//  Version: 0.0.3-alpha

import SwiftUI

struct ArticleDetailView: View {
    let article: PubMedArticle
<<<<<<< HEAD
    
=======

>>>>>>> cc80264 (Flattened directory structure using rsync)
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(article.title)
                    .font(.headline)
<<<<<<< HEAD
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
=======

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
>>>>>>> cc80264 (Flattened directory structure using rsync)
                        .foregroundColor(.blue)
                } else {
                    Text("No valid link available")
                        .foregroundColor(.gray)
                }
<<<<<<< HEAD
                
=======

>>>>>>> cc80264 (Flattened directory structure using rsync)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Article Details")
    }
}
