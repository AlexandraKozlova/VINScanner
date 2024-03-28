//
//  CameraView.swift
//  VINScanner
//
//  Created by USER on 12.03.2024.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var model = CameraViewModel()
    @State private var isShowingScanPicture = false
     
    var body: some View {
        NavigationStack {
            VStack {
                    ZStack {
                        CameraPreview()
                    }
                    ZStack {
                        Color.black
                            .ignoresSafeArea(.all)
                            .frame(height: 110)
                        if model.captureImage == nil {
                            Button(action: {
                                model.takePicture()
                            }) {
                                Image(systemName: "circle.inset.filled")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        } else {
                            HStack {
                                Button(action: {
                                    model.reTakePhoto()
                                }) {
                                    Text("Cancel")
                                        .tint(.white)
                                }
                                Spacer()
                                Button(action: {
                                    model.removeCapturePicture()
                                    isShowingScanPicture.toggle()
                                }) {
                                    Text("Use photo")
                                }
                            }
                            .padding()
                            
                            .navigationDestination(isPresented: $isShowingScanPicture) {
                                ScanView(scanImage: model.captureImage)
                            }
                        }
                    }
                    .toolbarBackground(Color.black, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                }
//            }
            .background(Color.black)
        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
