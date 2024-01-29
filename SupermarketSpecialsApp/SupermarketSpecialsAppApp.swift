//
//  SupermarketSpecialsAppApp.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//

import SwiftUI
import DesignLibrary

@main
struct SupermarketSpecialsAppApp: App {
    @StateObject var router = Router()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.stack) {
                TabView {
                    NavigationView{
                        PagesView()
                            .environmentObject(router)
                    }
                    .tabItem {
                        VStack {
                            Icon(iconName: .bag)
                            Text("Browse")
                        }
                    }
                    NavigationView{
                        SearchView()
                            .environmentObject(router)
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: "text.magnifyingglass")
                                .renderingMode(.template)
                            Text("Search")
                        }
                    }
                    
                    NavigationView {
                        ShoppingListView()
                            .environmentObject(router)
                    }
                    .tabItem {
                        VStack {
                            Icon(iconName: .list)
                            Text("Groceries List")
                        }
                    }
                }
                .navigationDestination(for: Destination.self) { nextView in
                    switch nextView {
                    case .itemDetails(let viewModel):
                        ItemDetailsView(viewModel: viewModel)
                            .padding(.horizontal, .medium)
                            .environmentObject(router)
                    }
                }
            }
        }
    }
}
