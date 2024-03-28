//
//  View+Ext.swift
//  VINScanner
//
//  Created by USER on 21.03.2024.
//

import SwiftUI

extension View {
    func showClearButton(_ text: Binding<String>) -> some View {
        self.modifier(TextFieldClearButton(fieldText: text))
    }
}
