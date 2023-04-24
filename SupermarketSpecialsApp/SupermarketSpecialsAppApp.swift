//
//  SupermarketSpecialsAppApp.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//

import SwiftUI

@main
struct SupermarketSpecialsAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView{
                    PagesView()
                }
                    .tabItem {
                        Text("pages")
                    }
                NavigationView{
                    SearchView()
                }
                    .tabItem {
                        Text("search")
                    }
            }
        }
    }
}
