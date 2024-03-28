//
//  TextFieldClearButton.swift
//  VINScanner
//
//  Created by USER on 21.03.2024.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var fieldText: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.trailing, 4)
                    }
                }
            }
    }
}
