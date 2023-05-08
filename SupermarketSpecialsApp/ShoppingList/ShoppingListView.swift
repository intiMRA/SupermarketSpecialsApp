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
        VStack {
            ForEach(viewModel.shoppingList, id:\.itemId) { item in
                ItemView(itemModel: item, isGrid: false, tapAction: { _ in })
            }
        }
        .task {
            viewModel.reload()
        }
    }
}
