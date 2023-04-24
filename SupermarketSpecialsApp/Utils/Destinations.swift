//
//  Destinations.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import Foundation
import SwiftUI

enum PagesViewDestinations: String {
    case itemDetails
}

class Router: ObservableObject {
    @Published var stack = NavigationPath()
}
