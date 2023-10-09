//
//  PagesView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//

import SwiftUI

struct PagesView: View {
    @StateObject var viewModel = PagesViewModel()
    @EnvironmentObject var router: Router
    var body: some View {
        VStack(spacing: .empty) {
            NavigationLink(value: PagesViewDestinations.itemDetails) {
                EmptyView()
            }
            ZStack {
                switch viewModel.state {
                case .listing:
                    listings
                case .category:
                    listings
                }
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
        .padding(.horizontal, .medium)
        .task {
            withAnimation {
                viewModel.fetchPage()
            }
        }
        .navigationDestination(for: PagesViewDestinations.self) { nextView in
            switch nextView {
            case .itemDetails:
                if let currentItem = viewModel.selectedItem, let itemGroup = viewModel.otherItems {
                    ItemDetailsView(viewModel: ItemDetailsViewModel(currentItem: currentItem, itemGroup: itemGroup))
                        .padding(.horizontal, .medium)
                        .environmentObject(router)
                }
            }
        }
        .animation(.default, value: viewModel.items)
    }
    
    @ViewBuilder
    var listings: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                LazyVStack(spacing: .large) {
                    let items = viewModel.items.items
                    ForEach(0..<items.count, id: \.self) { index in
                        let itemGroup = items[index]
                        ItemGroupView(items: itemGroup) { itemId in
                            viewModel.tapAction(itemId)
                            router.stack.append(PagesViewDestinations.itemDetails)
                        }
                        .task {
                            if index == Int(Double(items.count) * 0.8), viewModel.state == .listing {
                                viewModel.nextPage()
                            }
                        }
                    }
                }
            }
            .padding(.top, .xLarge)
            
            CategoriesChooser(expandCategory: $viewModel.showCategories, categories: viewModel.categories, selectedCategory: viewModel.selectedCategory, didSelectCategory: { category in
                viewModel.didSelectCategory(category)
            })
        }
    }
    
    @ViewBuilder
    var categoriesList: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.categories, id: \.self) { category in
                    Button {
                        withAnimation {
                            viewModel.didSelectCategory(category)
                        }
                    } label: {
                        HStack {
                            Text(category)
                            Spacer()
                        }
                    }
                }
            }
            .padding(.all, .medium)
        }
        .frame(maxWidth: .infinity)
    }
}
