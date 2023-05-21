//
//  ItemDetailsViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 28/04/23.
//

import Foundation

@MainActor
class ItemDetailsViewModel: ObservableObject {
    @Published var currentItem: ItemModel
    @Published var itemGroup: [ItemModel]
    
    init(currentItem: ItemModel, itemGroup: [ItemModel]) {
        self.currentItem = currentItem
        self.itemGroup = itemGroup
    }
    
    func didSelectItem(with itemId: String) {
        var allItems = itemGroup
        allItems.append(currentItem)
        guard let itemIndex = allItems.firstIndex(where: { $0.itemId == itemId }) else {
            return
        }
        let nextItem = allItems.remove(at: itemIndex)
        self.currentItem = nextItem
        self.itemGroup = allItems
    }
}
