//
//  ItemDetailsView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI
import DesignLibrary

struct ItemDetailsView: View {
    @StateObject var viewModel: ItemDetailsViewModel
    init(viewModel: ItemDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            VStack {
                NoTruncationText(viewModel.currentItem.name, isBold: true, font: .title)
                    .fixedSize(horizontal: true, vertical: false)
                HStack {
                    NoTruncationText(viewModel.currentItem.brand, isBold: true, font: .title2)
                    
                    NoTruncationText(viewModel.currentItem.price, isBold: true, font: .title2)
                }
                ImageView(url: viewModel.currentItem.photoUrl, size: .xLarge)
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
                                ImageView(url: otherItem.photoUrl, size: .medium)
                                NoTruncationText(otherItem.name, isBold: true)
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

struct ImageView: View {
    let url: String
    let size: CommonSizes
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .sized(size: size)
        } placeholder: {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .squareFrame(size: size)
        }
    }
}
