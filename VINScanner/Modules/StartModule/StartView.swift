//
//  ContentView.swift
//  VINScanner
//
//  Created by USER on 12.03.2024.
//

import SwiftUI
import AVFoundation

struct StartView: View {
    @State private var isNextScreenActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.teal.opacity(0.1)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image(systemName: "car.2")
                        .resizable()
                        .frame(width: 140, height: 100)
                        .foregroundColor(.teal)
                    Spacer()
                    Button(action: {
                        isNextScreenActive = true
                    }) {
                        Text("Scan VIN")
                            .foregroundColor(.teal)
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding()
                    
                    .navigationDestination(isPresented: $isNextScreenActive) {
                        CameraView()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    StartView()
}
