//  SearchView.swift
//  My PubMed Research Assistant
//
//  Description: UI for searching PubMed articles and displaying results.
//  Version: 0.6.3-alpha (Fixed UIKit Constraint Override)

import SwiftUI

struct SearchView: View {
    @State private var searchQuery = ""
    @State private var isKeyboardVisible = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TextField("Search PubMed", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                        isKeyboardVisible = true
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        isKeyboardVisible = false
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: isKeyboardVisible ? 3 : 0)
                    .animation(.easeInOut, value: isKeyboardVisible)
                    
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.secondarySystemBackground))
            .ignoresSafeArea(.keyboard, edges: .bottom) // Prevents UIKit conflicts
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
