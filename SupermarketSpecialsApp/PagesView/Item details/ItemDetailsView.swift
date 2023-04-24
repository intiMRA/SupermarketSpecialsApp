//
//  ItemDetailsView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct ItemDetailsView: View {
    let item: ItemModel
    let otherItems: [ItemModel]
    var body: some View {
        VStack {
            Text(item.name)
                .font(.title)
                .bold()
            AsyncImage(url: URL(string: item.photoUrl)) { image in
                image
                    .resizable()
                    .frame(width: 400, height: 400)
            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray)
                    .frame(width: 400, height: 400)
            }
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(otherItems, id: \.itemId) { otherItem in
                        VStack {
                            AsyncImage(url: URL(string: otherItem.photoUrl)) { image in
                                image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray)
                                    .frame(width: 100, height: 100)
                            }
                            Text(otherItem.name)
                                .bold()
                        }
                    }
                }
            }

        }
    }
}
