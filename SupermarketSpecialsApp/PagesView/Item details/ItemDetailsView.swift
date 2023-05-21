//
//  ItemDetailsView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct ItemDetailsView: View {
    @StateObject var viewModel: ItemDetailsViewModel
    init(viewModel: ItemDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.currentItem.name)
                    .font(.title)
                    .bold()
                HStack {
                    NoTruncationText(viewModel.currentItem.brand)
                        .font(.title2)
                        .bold()
                    
                    NoTruncationText(viewModel.currentItem.price)
                        .font(.title2)
                        .bold()
                }
                AsyncImage(url: URL(string: viewModel.currentItem.photoUrl)) { image in
                    image
                        .resizable()
                        .frame(width: 300, height: 300)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .frame(width: 300, height: 300)
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(SupermarketNames(rawValue: viewModel.currentItem.supermarket)?.color() ?? .white)
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(viewModel.itemGroup, id: \.itemId) { otherItem in
                        Button(action: {
                            withAnimation {
                                viewModel.didSelectItem(with: otherItem.itemId)
                            }
                        }) {
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
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(SupermarketNames(rawValue: otherItem.supermarket)?.color() ?? .white)
                            }
                        }
                    }
                }
            }

        }
    }
}
