//
//  CameraViewModel .swift
//  VINScanner
//
//  Created by USER on 19.03.2024.
//

import UIKit
import Vision
import Combine

class CameraViewModel: ObservableObject {
    @Published var error: Error?
    @Published var captureImage: CGImage?

    private let cameraHandler = CameraHandler.shared
    private var capturedImageRealTimeCancellable: AnyCancellable?
    private var requests = [VNRequest]()
   
    init() {
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        cameraHandler.$capturedPhoto
            .receive(on: DispatchQueue.main)
            .assign(to: &$captureImage)
    }
    
    func takePicture() {
        cameraHandler.takePic()
    }
    
    func reTakePhoto() {
        cameraHandler.reTake()
    }
    
    func removeCapturePicture() {
        cameraHandler.removeCapturePicture()
    }
}
