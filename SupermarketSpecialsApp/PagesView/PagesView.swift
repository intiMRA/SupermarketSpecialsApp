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
                ScrollView {
                    LazyVStack(spacing: .large) {
                        if let items = viewModel.items?.items {
                            ForEach(0..<items.count, id: \.self) { index in
                                let itemGroup = items[index]
                                ItemgroupView(items: itemGroup) { itemId in
                                    viewModel.tapAction(itemId)
                                    router.stack.append(PagesViewDestinations.itemDetails)
                                }
                            }
                        }
                    }
                }
                .padding(.top, .medium)
            case .loading:
                LoadingView()
            }
            
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
    }
}
