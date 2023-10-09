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
                VStack(alignment: .leading, spacing: .xSmall) {
                    if isGrid {
                        VStack(spacing: .large) {
                            AsyncImage(url: URL(string: itemModel.photoUrl)) { image in
                                image
                                    .resizable()
                                    .squareFrame(size: .medium)
                                    .cornerRadius(5)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.gray)
                                    .squareFrame(size: .medium)
                                    .cornerRadius(5)
                            }
                            NoTruncationText(itemModel.name, isBold: true, font: .headline)
                        }
                    } else {
                        HStack(spacing: .large) {
                            AsyncImage(url: URL(string: itemModel.photoUrl)) { image in
                                image
                                    .resizable()
                                    .squareFrame(size: .medium)
                                    .cornerRadius(5)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.gray)
                                    .squareFrame(size: .medium)
                                    .cornerRadius(5)
                            }
                            Spacer()
                            NoTruncationText(itemModel.name, isBold: true, font: .headline)
                        }
                    }
                    
                    
                    NoTruncationText(itemModel.brand, isBold: true)
                    
                    HStack(spacing: .large) {
                        NoTruncationText("$\(itemModel.price)", isBold: true, font: .subheadline)
                        
                        NoTruncationText(itemModel.size, isBold: true, font: .subheadline)
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
                        Text("Add to list")
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
