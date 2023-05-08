//
//  Store.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 8/05/23.
//

import Foundation
protocol StoreProtocol {
    func updateList(with item: ItemViewModel) async
    func updateList(with items: [ItemViewModel]) async
}

actor Store: StoreProtocol {
    static let shared = Store()
    private(set) var shoppingList: [ItemViewModel] = []
    private init() {}
    
    func updateList(with item: ItemViewModel) {
        self.shoppingList.append(item)
    }
    
    func updateList(with items: [ItemViewModel]) {
        self.shoppingList = items
    }
}
