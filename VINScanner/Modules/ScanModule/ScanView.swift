//
//  ScanView.swift
//  VINScanner
//
//  Created by USER on 13.03.2024.
//

import SwiftUI
import Vision

struct ScanView: View {
    @StateObject private var model = ScanViewModel()
    @State var text: String = ""
    @State var isCheakingText = false
    
    var scanImage: CGImage?
    
    var body: some View {
        ZStack {
            if let image = scanImage {
                GeometryReader { geometry in
                    Image(uiImage: UIImage(cgImage: image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width)
                        .clipped()
                        .onAppear {
                            model.detectText(in: image)
                        }
                       
                    ForEach(model.textRectangles, id: \.self) { rectangle in
                        RectanglePathView(rectangle: rectangle,
                                          width: geometry.size.width,
                                          height: image.width > image.height ? (geometry.size.height * 0.328) : geometry.size.height)
                        .contentShape(Rectangle())
                        .onTapGesture { tapLocation in
                            handleTap(at: tapLocation, 
                                      imageSize: CGSize(width: image.width, height: image.height),
                                      viewSize: image.width > image.height ? CGSize(width: geometry.size.width, height: (geometry.size.height * 0.328)) : CGSize(width: geometry.size.width, height: geometry.size.height))
                        }
                    }
                }
                .ignoresSafeArea(.keyboard)
                
                if isCheakingText {
                    CheckingTextView(text: $text,
                                     isChekingText: $isCheakingText)
                    .frame(height: 130)
                    .padding()
                }
                
            } else {
                Color.black
            }
        }
        .navigationTitle("Scan picture")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func handleTap(at tapLocation: CGPoint, imageSize: CGSize, viewSize: CGSize) {
        let imageTapLocation = CGPoint(x: tapLocation.x / viewSize.width * imageSize.width, y: tapLocation.y / viewSize.height * imageSize.height)
        
        for recognition in model.textRectangles {
            let rect = CGRect(x: recognition.box.origin.x * imageSize.width,
                              y: (1.0 - recognition.box.maxY) * imageSize.height,
                              width: recognition.box.width * imageSize.width,
                              height: recognition.box.height * imageSize.height)
            if rect.contains(imageTapLocation) {
                text.append(recognition.text)
                isCheakingText = true
                print(recognition.text)
                break
            }
        }
    }
}
