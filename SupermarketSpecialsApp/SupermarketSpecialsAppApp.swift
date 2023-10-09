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
    @StateObject var stack = Router()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $stack.stack) {
                TabView {
                    NavigationView{
                        PagesView()
                            .environmentObject(stack)
                    }
                    .tabItem {
                        VStack {
                            Icon(iconName: .bag)
                            Text("Browse")
                        }
                    }
                    NavigationView{
                        SearchView()
                            .environmentObject(stack)
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: "text.magnifyingglass")
                                .renderingMode(.template)
                            Text("Search")
                        }
                    }
                    
                    NavigationView{
                        ShoppingListView()
                            .environmentObject(stack)
                    }
                    .tabItem {
                        VStack {
                            Icon(iconName: .list)
                            Text("Groceries List")
                        }
                    }
                }
                
            }
        }
    }
}
