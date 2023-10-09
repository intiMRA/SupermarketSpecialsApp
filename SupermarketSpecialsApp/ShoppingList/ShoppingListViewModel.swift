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
    
    var groupedList: [(key: String, value: [ItemViewModel])] {
        shoppingList.reduce([String: [ItemViewModel]](), { partialResult, item in
            var partialResult = partialResult
            var superMarketItems = partialResult[item.supermarket]
            if superMarketItems == nil {
                superMarketItems = []
            }
            superMarketItems?.append(item)
            partialResult[item.supermarket] = superMarketItems
            return partialResult
        })
        .sorted(by: { $0.key > $1.key })
    }
    
    init() {
        self.reload()
    }
    
    func reload() {
        Task {
            self.shoppingList = await Store.shared.shoppingList
        }
    }
}
