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
                Section {
                    ForEach(itemGroup.value, id:\.itemId) { item in
                        NavigationLink(destination: { ItemView( itemModel: item, isGrid: false, tapAction: { _ in }, hasAddButton: false)}) {
                            HStack {
                                Text(item.name)
                                    .foregroundColor(.black)
                                Spacer()
                                Text(item.price)
                                    .foregroundColor(.black)
                            }
                            .frame(minHeight: 44)
                        }
                    }
                } header: {
                    Text(SupermarketNames(rawValue: itemGroup.key)?.name() ?? "")
                        .bold()
                }
            }
            .task {
                viewModel.reload()
            }
        }
        .padding(.horizontal, .medium)
    }
}
