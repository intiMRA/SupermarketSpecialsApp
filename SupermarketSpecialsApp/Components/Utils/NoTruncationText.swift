//
//  NoTruncationText.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct NoTruncationText: View {
    let text: String
    let isBold: Bool
    let font: Font
    
    init(_ text: String, isBold: Bool = false, font: Font = .body) {
        self.text = text
        self.isBold = isBold
        self.font = font
    }
    
    var body: some View {
        Text(text)
            .bold(isBold)
            .font(font)
            .foregroundColor(.black)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
