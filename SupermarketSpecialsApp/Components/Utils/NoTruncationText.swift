//
//  NoTruncationText.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct NoTruncationText: View {
    let text: String
    init(_ text: String) {
        self.text = text
    }
    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
