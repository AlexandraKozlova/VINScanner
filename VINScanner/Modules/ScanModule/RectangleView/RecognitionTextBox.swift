//
//  RecognitionTextBox.swift
//  VINScanner
//
//  Created by USER on 18.03.2024.
//

import Foundation

struct RecognitionTextBox: Hashable {
    let box: CGRect
    let text: String
    
    var topLeft: CGPoint {
        return box.origin
    }
    
    var topRight: CGPoint {
        return CGPoint(x: box.origin.x + box.width, y: box.origin.y)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: box.origin.x, y: box.origin.y + box.height)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: box.origin.x + box.width, y: box.origin.y + box.height)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}
