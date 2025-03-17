//  ContentView.swift
//  My PubMed Research Assistant
//
//  Description: Main content view containing navigation.
//  Version: 0.0.1-alpha

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SearchView()
                .navigationTitle("PubMed Search")
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing // Fix input errors
                }
        }
    }
}
