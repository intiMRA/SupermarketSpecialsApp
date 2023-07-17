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
            switch viewModel.state {
            case .listing:
                listings
            case .loading:
                LoadingView()
            }
            navigationButtons
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
        .sheet(isPresented: $viewModel.showCategories) {
            categoriesList
        }
    }
    
    @ViewBuilder
    var listings: some View {
        ScrollView {
            let cat = viewModel.selectedCategory ?? "All"
            Button {
                viewModel.tappedExpandCategories()
            } label: {
                Text("Category: \(cat)")
            }
            
            LazyVStack(spacing: .large) {
                if let items = viewModel.items?.items {
                    ForEach(0..<items.count, id: \.self) { index in
                        let itemGroup = items[index]
                        ItemGroupView(items: itemGroup) { itemId in
                            viewModel.tapAction(itemId)
                            router.stack.append(PagesViewDestinations.itemDetails)
                        }
                    }
                }
            }
        }
        .padding(.top, .medium)
    }
    
    @ViewBuilder
    var navigationButtons: some View {
        HStack {
            Button {
                withAnimation {
                    viewModel.backPage()
                }
            } label: {
                Text("Previous")
                    .padding(.all, .xxSmall)
            }
            .background(Color.mint.opacity(0.7))
            .cornerRadius(5)
            
            Spacer()
            
            Button {
                withAnimation {
                    viewModel.nextPage()
                }
            } label: {
                Text("next")
                    .padding(.all, .xxSmall)
            }
            .background(Color.mint.opacity(0.7))
            .cornerRadius(5)
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
