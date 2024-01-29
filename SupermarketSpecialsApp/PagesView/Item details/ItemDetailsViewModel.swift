//
//  ItemDetailsViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 28/04/23.
//

import Foundation

class ItemDetailsViewModel: ObservableObject, Equatable, Hashable {
    static func == (lhs: ItemDetailsViewModel, rhs: ItemDetailsViewModel) -> Bool {
        lhs.currentItem == rhs.currentItem
        && lhs.itemGroup == rhs.itemGroup
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(currentItem)
        hasher.combine(itemGroup)
    }
    
    @Published private(set) var currentItem: ItemModel
    @Published private(set) var itemGroup: [ItemModel]
    
    init(currentItem: ItemModel, itemGroup: [ItemModel]) {
        self.currentItem = currentItem
        self.itemGroup = itemGroup
    }
    
    @MainActor
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

