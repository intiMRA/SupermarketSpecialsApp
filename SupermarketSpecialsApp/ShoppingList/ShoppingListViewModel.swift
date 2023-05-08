//
//  ShoppingListViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 8/05/23.
//

import Foundation
@MainActor
class ShoppingListViewModel: ObservableObject {
    @Published var shoppingList: [ItemViewModel] = []
    
    init() {
        self.reload()
    }
    
    func reload() {
        Task {
            self.shoppingList = await Store.shared.shoppingList
        }
    }
}
