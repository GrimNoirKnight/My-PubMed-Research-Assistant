//
//  CleanTextField.swift
//  My PubMed Research Assistant
//
//  Created by Alan Keizer on 3/21/25.
//


//  CleanTextField.swift
//  My PubMed Research Assistant
//
//  Description: UIKit-wrapped TextField to remove InputAssistantView constraint crash
//  Version: 0.1.0-alpha

import SwiftUI
import UIKit

struct CleanTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var onCommit: () -> Void

    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.placeholder = placeholder
        field.font = UIFont(name: "Arial", size: 12)
        field.borderStyle = .roundedRect
        field.returnKeyType = .search
        field.delegate = context.coordinator

        // ✅ Disable input assistant (crashes layout on iOS keyboard)
        let item = field.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []

        return field
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CleanTextField

        init(_ parent: CleanTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ tf: UITextField) {
            parent.text = tf.text ?? ""
        }

        func textFieldShouldReturn(_ tf: UITextField) -> Bool {
            tf.resignFirstResponder()
            parent.onCommit()
            return true
        }
    }
}
