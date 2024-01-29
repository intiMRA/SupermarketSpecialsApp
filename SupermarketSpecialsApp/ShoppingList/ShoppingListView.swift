//
//  ShoppingListView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 8/05/23.
//

import Foundation
import SwiftUI

struct ShoppingListView: View {
    @StateObject var viewModel = ShoppingListViewModel()
    var body: some View {
        List {
            ForEach(viewModel.groupedList, id:\.key) { itemGroup in
                if let superMarket = SupermarketNames(rawValue: itemGroup.key) {
                    Section {
                        ForEach(itemGroup.value, id:\.itemId) { item in
                            NavigationLink(destination: { ItemView( itemModel: item, isGrid: false, tapAction: { _ in }, hasAddButton: false)}) {
                                HStack {
                                    Text(item.name)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text(item.price.asCurrencyString())
                                        .foregroundColor(.black)
                                }
                                .frame(minHeight: 44)
                            }
                        }
                    } header: {
                        Text(superMarket.name())
                            .bold()
                    }
                    .listRowBackground(superMarket.color())
                }
            }
        }
        .listStyle(.sidebar)
        .task {
            viewModel.reload()
        }
    }
}
