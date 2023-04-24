//
//  ItemView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct ItemViewModel {
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
    
    var body: some View {
        Button(action: {}) {
            VStack {
                if isGrid {
                    VStack(spacing: 20) {
                        AsyncImage(url: URL(string: itemModel.photoUrl)) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 100, height: 100)
                        }
                        NoTruncationText(itemModel.name)
                            .bold()
                    }
                } else {
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: itemModel.photoUrl)) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 100, height: 100)
                        }
                        Spacer()
                        NoTruncationText(itemModel.name)
                            .bold()
                    }
                }
                
                
                NoTruncationText(itemModel.brand)
                    .bold()
                
                HStack(spacing: 20) {
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
