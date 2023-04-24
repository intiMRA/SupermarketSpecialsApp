//
//  ItemsModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import Foundation

struct ItemModel: Codable {
    let brand: String
    let category: String
    let itemId: String
    let name: String
    let photoUrl: String
    let price: String
    let size: String
    let supermarket: String
    let supermarketId: String?
}

struct ItemsModel: Codable {
    let items: [[ItemModel]]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let items = try container.decode([[ItemModel]].self, forKey: .items)
        self.items = items.map({ itemGroup in
            itemGroup.map { item in
                    .init(brand: item.brand,
                          category: item.category,
                          itemId: UUID().uuidString,
                          name: item.name,
                          photoUrl: item.photoUrl,
                          price: item.price,
                          size: item.size,
                          supermarket: item.supermarket,
                          supermarketId: item.supermarketId)
            }
        })
    }
}
