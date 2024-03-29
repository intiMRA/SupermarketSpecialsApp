//
//  SearchView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @EnvironmentObject var router: Router
    var body: some View {
        VStack {
            switch viewModel.state {
            case .entry:
                EmptyView()
            case .loading:
                LoadingView()
            case .showingItems:
                ScrollView {
                    LazyVStack(spacing: .large) {
                        if let items = viewModel.items?.items {
                            ForEach(0..<items.count, id: \.self) { index in
                                let itemGroup = items[index]
                                ItemGroupView(items: itemGroup, tapAction: { itemId in
                                    viewModel.tapAction(itemId)
                                    router.stack.append(SearchViewDestinations.itemDetails)
                                })
                                .padding(.horizontal, .medium)
                            }
                        }
                    }
                }
            }
        }
        .navigationDestination(for: SearchViewDestinations.self) { nextView in
            switch nextView {
            case .itemDetails:
                if let currentItem = viewModel.selectedItem, let itemGroup = viewModel.otherItems {
                    ItemDetailsView(viewModel: ItemDetailsViewModel(currentItem: currentItem, itemGroup: itemGroup))
                        .padding(.horizontal, .medium)
                        .environmentObject(router)
                }
            }
        }
        .searchable(text: $viewModel.query)
    }
}
