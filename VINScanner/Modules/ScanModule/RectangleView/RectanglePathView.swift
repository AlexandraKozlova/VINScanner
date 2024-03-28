//
//  RectanglePathView.swift
//  VINScanner
//
//  Created by USER on 18.03.2024.
//

import SwiftUI

struct RectanglePathView: View {
    let rectangle: RecognitionTextBox
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .stroke(Color.red, lineWidth: 2)
            .frame(width: width * rectangle.box.width,
                   height: height * rectangle.box.height)
            .position(x: width * rectangle.box.midX,
                      y: height * (1.0 - rectangle.box.midY))
            .contentShape(Rectangle())
        
        // Alternative option for displaying a rectangle
        
//        let topLeft = CGPoint(x: rectangle.topLeft.x * width,
//                              y: (1.0 - rectangle.topLeft.y) * height)
//        let bottomLeft = CGPoint(x: rectangle.bottomLeft.x * width,
//                                 y: (1.0 - rectangle.bottomLeft.y) * height)
//        let topRight = CGPoint(x: rectangle.topRight.x * width,
//                               y: (1.0 - rectangle.topRight.y) * height)
//        let bottomRight = CGPoint(x: rectangle.bottomRight.x * width,
//                                  y: (1.0 - rectangle.bottomRight.y) * height)
//        
//        Path { path in
//            let lineStart = CGPoint(x: bottomLeft.x, y: (topLeft.y + bottomLeft.y + 3) / 2)
//            let lineEnd = CGPoint(x: topLeft.x, y: topLeft.y)
//            
//            let distance = lineStart.distance(to: lineEnd)
//            let controlPoint = CGPoint(x: lineEnd.x + distance, y: topLeft.y)
//            
//            path.move(to: lineStart)
//            path.addLine(to: lineEnd)
//            path.addQuadCurve(to: controlPoint, control: lineEnd)
//        }
//        .stroke(Color.yellow, lineWidth: 2)
//        
//        Path { path in
//            let lineStart = CGPoint(x: bottomRight.x, y: (topLeft.y + bottomRight.y + 3) / 2)
//            let lineEnd = CGPoint(x: topRight.x, y: topRight.y)
//            
//            let distance = lineStart.distance(to: lineEnd)
//            let controlPoint = CGPoint(x: lineEnd.x - distance, y: topRight.y)
//            
//            path.move(to: lineStart)
//            path.addLine(to: lineEnd)
//            path.addQuadCurve(to: controlPoint, control: lineEnd)
//        }
//        .stroke(Color.yellow, lineWidth: 2)
//        
//        Path { path in
//            let lineStart = CGPoint(x: bottomLeft.x, y: (topLeft.y + bottomLeft.y - 3) / 2)
//            let lineEnd = CGPoint(x: bottomLeft.x, y: bottomLeft.y)
//            
//            let distance = lineStart.distance(to: lineEnd)
//            let controlPoint = CGPoint(x: lineEnd.x + distance, y: bottomLeft.y)
//            
//            path.move(to: lineStart)
//            path.addLine(to: lineEnd)
//            path.addQuadCurve(to: controlPoint, control: lineEnd)
//        }
//        .stroke(Color.yellow, lineWidth: 2)
//        
//        Path { path in
//            let lineStart = CGPoint(x: bottomRight.x, y: (topLeft.y + bottomRight.y - 3) / 2)
//            let lineEnd = CGPoint(x: bottomRight.x, y: bottomRight.y)
//            
//            let distance = lineStart.distance(to: lineEnd)
//            let controlPoint = CGPoint(x: lineEnd.x - distance, y: bottomRight.y)
//            
//            path.move(to: lineStart)
//            path.addLine(to: lineEnd)
//            path.addQuadCurve(to: controlPoint, control: lineEnd)
//        }
//        .stroke(Color.yellow, lineWidth: 2)
    }
}
