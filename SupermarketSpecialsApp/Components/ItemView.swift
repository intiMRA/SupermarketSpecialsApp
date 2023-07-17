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
    let hasAddButton: Bool
    
    init(itemModel: ItemViewModel, isGrid: Bool, tapAction: @escaping (String) -> Void, hasAddButton: Bool = true) {
        self.itemModel = itemModel
        self.isGrid = isGrid
        self.tapAction = tapAction
        self.hasAddButton = hasAddButton
    }
    
    var body: some View {
        VStack {
            Button(action: {
                tapAction(itemModel.itemId)
            }) {
                VStack {
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
                            NoTruncationText(itemModel.name, isBold: true)
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
                            NoTruncationText(itemModel.name, isBold: true)
                        }
                    }
                    
                    
                    NoTruncationText(itemModel.brand, isBold: true)
                    
                    HStack(spacing: .large) {
                        NoTruncationText(itemModel.price, isBold: true)
                        
                        NoTruncationText(itemModel.size, isBold: true)
                    }
                }
            }
            
            if hasAddButton {
                Button {
                    Task {
                        await Store.shared.updateShoppingList(with: itemModel)
                    }
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
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
