//
//  PagesView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//

import SwiftUI

struct PagesView: View {
    @StateObject var viewModel = PagesViewModel()
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
    }
}
