//
//  ItemGroupView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct ItemgroupView: View {
    let items: [ItemModel]
    let tapAction: (String) -> Void
    var body: some View {
        if items.count > 1 {
            let cols: [GridItem] = [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 100))]
                LazyVGrid(columns: cols) {
                    ForEach(items, id:\.itemId) { item in
                        ItemView(itemModel: .init(
                            itemId: items[0].itemId,
                            name: item.name,
                            photoUrl: item.photoUrl,
                            price: item.price,
                            brand: item.brand,
                            size: item.size,
                            supermarket: item.supermarket),
                                 isGrid: true,
                                 tapAction: tapAction)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.cyan)
                        .opacity(0.2)
                }
            
        } else {
            ItemView(itemModel: .init(
                itemId: items[0].itemId,
                name: items[0].name,
                photoUrl: items[0].photoUrl,
                price: items[0].price,
                brand: items[0].brand,
                size: items[0].size,
                supermarket: items[0].supermarket),
                     isGrid: false,
                     tapAction: tapAction)
        }
    }
}

