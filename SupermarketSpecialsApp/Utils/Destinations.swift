//
//  Destinations.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import Foundation
import SwiftUI

enum Destination: Hashable, Equatable {
    case itemDetails(ItemDetailsViewModel)
}

class Router: ObservableObject {
    @Published var stack = NavigationPath()
    
    func navigate(to destination: Destination) {
        stack.append(destination)
    }
    
    func pop() {
        stack.removeLast()
    }
}
