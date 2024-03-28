//
//  CGPoint+Ext.swift
//  VINScanner
//
//  Created by USER on 21.03.2024.
//

import Foundation

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let deltaX = self.x - point.x
        let deltaY = self.y - point.y
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
}
