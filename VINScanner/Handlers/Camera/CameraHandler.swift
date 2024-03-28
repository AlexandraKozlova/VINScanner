//
//  CameraHandler.swift
//  VINScanner
//
//  Created by USER on 12.03.2024.
//
import AVFoundation
import Vision
import UIKit
import SwiftUI

class CameraHandler: NSObject, ObservableObject {
    static let shared = CameraHandler()
    
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var capturedPhoto: CGImage?
    
    private var deviceInput: AVCaptureDeviceInput?
    private var videoDeviceRotationCoordinator: AVCaptureDevice.RotationCoordinator!
    private var photoOutputReadinessCoordinator: AVCapturePhotoOutputReadinessCoordinator!
    private let videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    override init() {
        super.init()
        checkPermissions()
    }
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status {
                    self.setUp()
                } else {
                    self.alert.toggle()
                }
            }
        case .denied:
            self.alert.toggle()
        default:
            break
        }
    }
    
    func setUp() {
        do {
            self.session.beginConfiguration()
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
            let input = try AVCaptureDeviceInput(device: device!)
            self.deviceInput = input
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output) {
                self.session.addOutput (self.output)
            }
            DispatchQueue.main.async {
                self.createDeviceRotationCoordinator()
            }
            self.session.commitConfiguration()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        }
    }
    
    func reTake() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            self.capturedPhoto = nil
        }
    }
    
    func removeCapturePicture() {
        capturedPhoto = nil
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CameraHandler: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard error == nil else {
            print("Error capturing photo: \(error!.localizedDescription)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            print("Failed to convert photo to image.")
            return
        }
        
        let scaledImage = scaleAndOrient(image: image)
        
        DispatchQueue.main.async {
            self.session.stopRunning()
            self.capturedPhoto = scaledImage.cgImage
        }
    }
}

// MARK: - Private orientation setup
private extension CameraHandler {
    func createDeviceRotationCoordinator() {
        guard let deviceInput else { return }
        
        videoDeviceRotationCoordinator = AVCaptureDevice.RotationCoordinator(device: deviceInput.device,
                                                                             previewLayer: videoPreviewLayer)
        videoPreviewLayer.connection?.videoRotationAngle = videoDeviceRotationCoordinator.videoRotationAngleForHorizonLevelPreview
    }
    
    func scaleAndOrient(image: UIImage) -> UIImage {
        let maxResolution: CGFloat = 640
        let videoRotationAngle = self.videoDeviceRotationCoordinator.videoRotationAngleForHorizonLevelCapture
        
        guard let cgImage = image.cgImage else {
            print("UIImage has no CGImage backing it!")
            return image
        }
        
        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)
        var transform = CGAffineTransform.identity
        
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        if width > maxResolution || height > maxResolution {
            let ratio = width / height
            if width > height {
                bounds.size.width = maxResolution
                bounds.size.height = round(maxResolution / ratio)
            } else {
                bounds.size.width = round(maxResolution * ratio)
                bounds.size.height = maxResolution
            }
        }
        
        let scaleRatio = bounds.size.width / width
        
        switch videoRotationAngle {
        case 90, 270:
            let boundsHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundsHeight
            transform = CGAffineTransform(translationX: height, y: 0).rotated(by: .pi / 2.0)
        case 0: return image
        case 180: transform = CGAffineTransform(translationX: width, y: height).rotated(by: .pi)
        default: return image
        }
        
        return UIGraphicsImageRenderer(size: bounds.size).image { rendererContext in
            let context = rendererContext.cgContext
            
            if videoRotationAngle == 90 {
                context.scaleBy(x: -scaleRatio, y: scaleRatio)
                context.translateBy(x: -height, y: 0)
            } else  {
                context.scaleBy(x: scaleRatio, y: -scaleRatio)
                context.translateBy(x: 0, y: -height)
            }
            
            context.concatenate(transform)
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        }
    }
}
