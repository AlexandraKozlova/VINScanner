//
//  CheckingTextView.swift
//  VINScanner
//
//  Created by USER on 21.03.2024.
//

import SwiftUI

struct CheckingTextView: View {
    @State private var viewOffset = CGSize.zero
    @Binding var text: String
    @Binding var isChekingText: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Сheck the selected text or combine several options")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                        .padding(.leading, 10)
                    Spacer()
                    Button(action: {
                        text = ""
                        isChekingText = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray.opacity(0.5))
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    TextField("Text", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                        .showClearButton($text)
                    
                    Button(action: {}) {
                        Text("Okay")
                            .foregroundColor(.teal)
                            .padding()
                            .frame(height: 38)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    .padding(.trailing)
                }
                .padding(.top, 5)
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
            }
        }
        .offset(viewOffset)
    }
}
