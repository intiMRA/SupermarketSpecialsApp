//
//  ItemsModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import Foundation

struct ItemModel: Equatable, Codable , Hashable {
    let brand: String
    let category: String
    let itemId: String
    let name: String
    let photoUrl: String
    let price: Double
    let size: String
    let supermarket: String
    let supermarketId: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.brand, forKey: .brand)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.itemId, forKey: .itemId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.photoUrl, forKey: .photoUrl)
        try container.encode(self.price, forKey: .price)
        try container.encode(self.size, forKey: .size)
        try container.encode(self.supermarket, forKey: .supermarket)
        try container.encodeIfPresent(self.supermarketId, forKey: .supermarketId)
    }
    
    enum CodingKeys: CodingKey {
        case brand
        case category
        case itemId
        case name
        case photoUrl
        case price
        case size
        case supermarket
        case supermarketId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.brand = try container.decode(String.self, forKey: .brand)
        self.category = try container.decode(String.self, forKey: .category)
        self.itemId = try container.decode(String.self, forKey: .itemId)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoUrl = try container.decode(String.self, forKey: .photoUrl)
        let price = try container.decode(String.self, forKey: .price)
        guard let price = Double(price) else { fatalError() }
        self.price = price
        self.size = try container.decode(String.self, forKey: .size)
        self.supermarket = try container.decode(String.self, forKey: .supermarket)
        self.supermarketId = try container.decodeIfPresent(String.self, forKey: .supermarketId)
    }
    
    init(brand: String,
         category: String,
         itemId: String,
         name: String,
         photoUrl: String,
         price: Double,
         size: String,
         supermarket: String,
         supermarketId: String?) {
        self.brand = brand
        self.category = category
        self.itemId = itemId
        self.name = name
        self.photoUrl = photoUrl
        self.price = price
        self.size = size
        self.supermarket = supermarket
        self.supermarketId = supermarketId
    }
}

struct ItemsModel: Codable, Equatable {
    var items: [[ItemModel]]
    
    init(items: [[ItemModel]]) {
        self.items = items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let items = try container.decode([[ItemModel]].self, forKey: .items)
        self.items = items.map({ itemGroup in
            itemGroup.map { item in
                    return .init(brand: item.brand,
                          category: item.category,
                          itemId: UUID().uuidString,
                          name: item.name,
                          photoUrl: item.photoUrl,
                          price: Double(item.price),
                          size: item.size,
                          supermarket: item.supermarket,
                          supermarketId: item.supermarketId)
            }
        })
    }
}
