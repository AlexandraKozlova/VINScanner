//
//  CameraPreview.swift
//  VINScanner
//
//  Created by USER on 19.03.2024.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        CameraHandler.shared.preview = AVCaptureVideoPreviewLayer(session: CameraHandler.shared.session)
        CameraHandler.shared.preview.frame = view.frame
        CameraHandler.shared.preview.videoGravity = .resizeAspect
        view.layer.addSublayer(CameraHandler.shared.preview)
        DispatchQueue.global().async {
            CameraHandler.shared.session.startRunning()
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
