//
//  CategoriesChooser.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 31/07/23.
//

import SwiftUI
import DesignLibrary
struct CategoriesChooser: View {
    @Binding var expandCategory: Bool
    let categories: [String]
    let selectedCategory: String?
    let didSelectCategory: (String) -> Void
    var body: some View {
        let cat = selectedCategory ?? "All"
        Button {
            expandCategory = true
        } label: {
            HStack {
                HStack {
                    Text("Category: \(cat)")
                    Icon(iconName: .chevron, size: .small, color: .blue)
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $expandCategory) {
            categoriesList
        }
    }
    
    @ViewBuilder
    var categoriesList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .medium) {
                HStack {
                    Button {
                        self.expandCategory = false
                    } label: {
                        Text("Cancel")
                    }

                    Spacer()
                }
                Button {
                    didSelectCategory("")
                } label: {
                    HStack {
                        if selectedCategory?.isEmpty ?? true {
                            Text("All")
                                .foregroundColor(.black)
                                .bold()
                        }
                        else {
                            Text("All")
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        if selectedCategory?.isEmpty ?? true {
                            Icon(iconName: .tick, size: .small)
                        }
                    }
                }
                ForEach(categories, id: \.self) { category in
                    Button {
                        withAnimation {
                            didSelectCategory(category)
                        }
                    } label: {
                        HStack {
                            if category == selectedCategory {
                                Text(category)
                                    .bold()
                            }
                            else {
                                Text(category)
                            }
                            
                            Spacer()
                            if category == selectedCategory {
                                Icon(iconName: .tick, size: .small)
                            }
                        }
                    }
                    .foregroundColor(.black)
                }
            }
            .padding(.all, .medium)
        }
        .frame(maxWidth: .infinity)
    }
}
