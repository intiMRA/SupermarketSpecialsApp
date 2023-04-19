//
//  PagesView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//

import SwiftUI

enum Supemarkets: String {
    case countdown, newWorld, pakNSave
    func color() -> Color {
        switch self {
        case .countdown:
            return .green
        case .newWorld:
            return .red
        case .pakNSave:
            return .yellow
        }
    }
}
struct PagesView: View {
    @StateObject var viewModel = PagesViewModel()
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    if let items = viewModel.items?.items {
                        ForEach(0..<items.count, id: \.self) { index in
                            let itemGroup = items[index]
                            ItemgroupView(items: itemGroup)
                                .padding(.horizontal, 16)
                        }
                    } else {
                        Text("loading..")
                    }
                }
            }
            Button {
                Task {
                    await viewModel.nextPage()
                }
                
            } label: {
                Text("next")
            }
        }
        .task {
            await viewModel.fetchPage()
        }
    }
}

struct ItemgroupView: View {
    let items: [Item]
    var body: some View {
        if items.count > 1 {
            let cols: [GridItem] = [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 100))]
                LazyVGrid(columns: cols) {
                    ForEach(items, id:\.itemId) { item in
                        ItemView(itemModel: .init(
                            name: item.name,
                            photoUrl: item.photoUrl,
                            price: item.price,
                            brand: item.brand,
                            size: item.size,
                            supermarket: item.supermarket), isGrid: true)
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
                name: items[0].name,
                photoUrl: items[0].photoUrl,
                price: items[0].price,
                brand: items[0].brand,
                size: items[0].size,
                supermarket: items[0].supermarket), isGrid: false)
        }
    }
}

struct ItemModel {
    let name: String
    let photoUrl: String
    let price: String
    let brand: String
    let size: String
    let supermarket: String
}
struct ItemView: View {
    let itemModel: ItemModel
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
                .fill(Supemarkets(rawValue: itemModel.supermarket)?.color() ?? .white)
        }
        .frame(maxHeight: 300)
    }
}



struct NoTruncationText: View {
    let text: String
    init(_ text: String) {
        self.text = text
    }
    var body: some View {
        Text(text)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
