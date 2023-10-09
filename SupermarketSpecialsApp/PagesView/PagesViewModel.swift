//
//  PagesViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//
import NetworkLayerSPM
import Foundation

enum PagesViewState {
    case listing, category
}

struct CategoriesModel: Codable {
    let categoryNames: [String]
}

@MainActor
class PagesViewModel: ObservableObject {
    @Published var items = ItemsModel(items: [])
    @Published var page = 1
    @Published var state: PagesViewState = .listing
    @Published var isLoading = true
    @Published var selectedCategory: String?
    @Published var showCategories = false
    @Published var categories: [String] = []
    let store = Store.shared
    var selectedItem: ItemModel?
    var otherItems: [ItemModel]?
    
    func fetchPage() {
        Task {
            guard await store.pagesLists[page] == nil else {
                self.items = await store.allPageItems()
                state = .listing
                return
            }

            await self.fetchCategories()
            let request = NetworkLayerRequest(urlBuilder: EndpointUrls.pages(newWorlsIds: ["89ba1656-0ad7-4af0-8694-08bf335e99b9"], packNSaveIds: ["21ecaaed-0749-4492-985e-4bb7ba43d59c"], pageNumber: page), httpMethod: .GET)
            do {
                let items: ItemsModel? = try await NetworkLayer.defaultNetworkLayer.request(request)
                if var items = items {
                    items = ItemsModel(items: items.items)
                    await store.updatePagesList(page, itemModel: items)
                    self.items.items.append(contentsOf: items.items)
                }
            } catch {
                print(error)
            }
            state = .listing
            isLoading = false
        }
    }
    
    func fetchItems(with category: String) {
        Task {
            isLoading = true
            let request = NetworkLayerRequest(urlBuilder: EndpointUrls.items(newWorlsIds: ["89ba1656-0ad7-4af0-8694-08bf335e99b9"], packNSaveIds: ["21ecaaed-0749-4492-985e-4bb7ba43d59c"], category: category), httpMethod: .GET)
            do {
                let items: ItemsModel? = try await NetworkLayer.defaultNetworkLayer.request(request)
                if var items = items {
                    // TODO: change in server
                    items = ItemsModel(items: items.items)
                    self.items = items
                }
            } catch {
                print(error)
            }
            state = .category
            isLoading = false
        }
    }
    
    func tappedExpandCategories() {
        showCategories = true
    }
    
    func fetchCategories() async {
        guard await store.categoryNamesLists.isEmpty else {
            self.categories = await store.categoryNamesLists
            return
        }
        
        let request = NetworkLayerRequest(urlBuilder: EndpointUrls.categories, httpMethod: .GET)
        do {
            let cats: CategoriesModel = try await NetworkLayer.defaultNetworkLayer.request(request)
            await store.updateCategoryNamesLists(list: cats.categoryNames)
            self.categories = cats.categoryNames
        } catch {
            print(error)
        }
    }
    
    func nextPage() {
        page += 1
        self.fetchPage()
    }
    
    func tapAction(_ itemId: String) {
        let itemGroup = items.items.filter({ $0.contains { $0.itemId == itemId } })
        selectedItem = itemGroup.first?.first(where: { $0.itemId == itemId })
        otherItems = itemGroup.first?.filter { $0.itemId != itemId }
    }
    
    func didSelectCategory(_ category: String) {
        self.selectedCategory = category
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.showCategories = false
            if category.isEmpty {
                self.fetchPage()
            } else {
                self.fetchItems(with: category)
            }
        }
    }
}
