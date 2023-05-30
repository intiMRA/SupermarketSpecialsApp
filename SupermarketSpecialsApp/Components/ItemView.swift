//
//  ItemView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct ItemViewModel {
    let itemId: String
    let name: String
    let photoUrl: String
    let price: String
    let brand: String
    let size: String
    let supermarket: String
}

struct ItemView: View {
    let itemModel: ItemViewModel
    let isGrid: Bool
    let tapAction: (String) -> Void
    
    var body: some View {
        Button(action: {
            tapAction(itemModel.itemId)
        }) {
            VStack {
                Button {
                    Task {
                        await Store.shared.updateShoppingList(with: itemModel)
                    }
                } label: {
                    Text("Add")
                }

                if isGrid {
                    VStack(spacing: .large) {
                        AsyncImage(url: URL(string: itemModel.photoUrl)) { image in
                            image
                                .resizable()
                                .squareFrame(size: .medium)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                                .squareFrame(size: .medium)
                        }
                        NoTruncationText(itemModel.name)
                            .bold()
                    }
                } else {
                    HStack(spacing: .large) {
                        AsyncImage(url: URL(string: itemModel.photoUrl)) { image in
                            image
                                .resizable()
                                .squareFrame(size: .medium)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                                .squareFrame(size: .medium)
                        }
                        Spacer()
                        NoTruncationText(itemModel.name)
                            .bold()
                    }
                }
                
                
                NoTruncationText(itemModel.brand)
                    .bold()
                
                HStack(spacing: .large) {
                    NoTruncationText(itemModel.price)
                        .bold()
                    
                    NoTruncationText(itemModel.size)
                        .bold()
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(SupermarketNames(rawValue: itemModel.supermarket)?.color() ?? .white)
        }
        .frame(maxHeight: 300)
    }
}
