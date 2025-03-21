//
//  ContentView.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


//  ContentView.swift
//  My PubMed Research Assistant
//
//  Description: Root navigation entry point.
//  Version: 0.0.1-alpha

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SearchView()
                .navigationTitle("PubMed Search")
        }
    }
}
