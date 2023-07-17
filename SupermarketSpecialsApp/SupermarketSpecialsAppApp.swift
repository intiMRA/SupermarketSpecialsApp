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
                        Icon(iconName: .bag)
                    }
                    NavigationView{
                        SearchView()
                            .environmentObject(stack)
                    }
                    .tabItem {
                        Image(systemName: "text.magnifyingglass")
                            .renderingMode(.template)
                    }
                    
                    NavigationView{
                        ShoppingListView()
                            .environmentObject(stack)
                    }
                    .tabItem {
                        Icon(iconName: .list)
                    }
                }
                
            }
        }
    }
}
