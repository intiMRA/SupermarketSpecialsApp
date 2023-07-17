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
        ScrollView {
            VStack {
                ForEach(viewModel.shoppingList.sorted(by: { ($0.supermarket, $0.name) < ($1.supermarket, $1.name)}), id:\.itemId) { item in
                    ItemView(itemModel: item, isGrid: false, tapAction: { _ in }, hasAddButton: false)
                }
            }
            .task {
                viewModel.reload()
            }
        }
        .padding(.horizontal, .medium)
    }
}
