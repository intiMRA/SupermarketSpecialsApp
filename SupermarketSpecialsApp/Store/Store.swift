//
//  Store.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 8/05/23.
//

import Foundation
protocol StoreProtocol {
    func updateShoppingList(with item: ItemViewModel) async
    func updateShoppingList(with items: [ItemViewModel]) async
}

actor Store: StoreProtocol {
    static let shared = Store()
    private(set) var shoppingList: [ItemViewModel] = []
    private(set) var pagesLists: [Int: ItemsModel] = [:]
    private(set) var categoryNamesLists: [String] = []
    private init() {}
    
    func updateShoppingList(with item: ItemViewModel) {
        self.shoppingList.append(item)
    }
    
    func updateShoppingList(with items: [ItemViewModel]) {
        self.shoppingList = items
    }
    
    func updatePagesList(_ page: Int, itemModel: ItemsModel) {
        self.pagesLists[page] = itemModel
    }
    
    func updateCategoryNamesLists(list: [String]) {
        self.categoryNamesLists = list
    }
    
    func allPageItems() -> ItemsModel {
        self.pagesLists.reduce(ItemsModel(items: [])) { partialResult, kv in
            var items = partialResult.items
            items.append(contentsOf: kv.value.items)
            return ItemsModel(items: items)
        }
    }
}
