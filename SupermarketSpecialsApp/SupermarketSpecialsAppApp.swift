//
//  SupermarketSpecialsAppApp.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//

import SwiftUI

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
                        Text("pages")
                    }
                    NavigationView{
                        SearchView()
                            .environmentObject(stack)
                    }
                    .tabItem {
                        Text("search")
                    }
                }
                
            }
        }
    }
}
