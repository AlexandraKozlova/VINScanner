//
//  ScanViewModel.swift
//  VINScanner
//
//  Created by USER on 20.03.2024.
//

import UIKit
import Vision

class ScanViewModel: ObservableObject {
    @Published var textRectangles: [RecognitionTextBox] = []
    
    func detectText(in image: CGImage) {
        let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
        let textDetectionRequest = VNDetectTextRectanglesRequest { request, _ in
            guard let observations = request.results as? [VNRectangleObservation] else {
                return }
            
            DispatchQueue.main.async {
                self.recognizeText(in: image, rectangles: observations)
            }
        }
        textDetectionRequest.reportCharacterBoxes = true
        
        do {
            try requestHandler.perform([textDetectionRequest])
        } catch {
            print("Error performing text detection: \(error.localizedDescription)")
        }
    }
    
    private func recognizeText(in image: CGImage, rectangles: [VNRectangleObservation]) {
        let recognizeTextRequest = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                return
            }
            
            for observation in observations {
                let recognizedText = observation.topCandidates(1).first?.string ?? ""
                self.textRectangles.append(RecognitionTextBox(box: observation.boundingBox,
                                                              text: recognizedText))
            }
        }
        
        do {
            try VNImageRequestHandler(cgImage: image, options: [:]).perform([recognizeTextRequest])
        } catch {
            print("Error performing text recognition: \(error.localizedDescription)")
        }
    }
}
