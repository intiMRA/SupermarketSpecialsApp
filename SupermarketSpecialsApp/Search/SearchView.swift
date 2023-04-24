//
//  SearchView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
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
        }
        .task {
            await viewModel.search()
        }
    }
}
