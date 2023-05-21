//
//  SupermarketNames.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import Foundation
import SwiftUI

enum SupermarketNames: String {
    case countdown, newWorld, pakNSave
    func color() -> Color {
        switch self {
        case .countdown:
            return .green
        case .newWorld:
            return .red
        case .pakNSave:
            return .yellow
        }
    }
}
