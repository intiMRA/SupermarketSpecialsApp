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
        VStack {
            NavigationLink(value: PagesViewDestinations.itemDetails) {
                EmptyView()
            }
            
            ScrollView {
                LazyVStack(spacing: 20) {
                    if let items = viewModel.items?.items {
                        ForEach(0..<items.count, id: \.self) { index in
                            let itemGroup = items[index]
                            ItemgroupView(items: itemGroup) { itemId in
                                viewModel.tapAction(itemId)
                                router.stack.append(PagesViewDestinations.itemDetails)
                            }
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
        .navigationDestination(for: PagesViewDestinations.self) { nextView in
            switch nextView {
            case .itemDetails:
                if let currentItem = viewModel.selectedItem, let itemGroup = viewModel.otherItems {
                    ItemDetailsView(viewModel: ItemDetailsViewModel(currentItem: currentItem, itemGroup: itemGroup))
                        .padding(.horizontal, 16)
                        .environmentObject(router)
                }
            }
        }
    }
}
