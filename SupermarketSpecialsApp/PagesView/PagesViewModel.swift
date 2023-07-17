//
//  PagesViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//
import NetworkLayerSPM
import Foundation

enum PagesViewState {
    case loading, listing
}

struct CategoriesModel: Codable {
    let categoryNames: [String]
}

@MainActor
class PagesViewModel: ObservableObject {
    @Published var items: ItemsModel?
    @Published var page = 1
    @Published var state: PagesViewState = .loading
    @Published var selectedCategory: String?
    @Published var showCategories = false
    @Published var categories: [String] = []
    let store = Store.shared
    var selectedItem: ItemModel?
    var otherItems: [ItemModel]?
    
    func fetchPage() {
        Task {
            guard await store.pagesLists[page] == nil else {
                self.items = await store.pagesLists[page]
                state = .listing
                return
            }
            
            state = .loading
            await self.fetchCategories()
            let request = NetworkLayerRequest(urlBuilder: EndpointUrls.pages(newWorlsIds: ["89ba1656-0ad7-4af0-8694-08bf335e99b9"], packNSaveIds: ["21ecaaed-0749-4492-985e-4bb7ba43d59c"], pageNumber: page), httpMethod: .GET)
            do {
                items = try await NetworkLayer.defaultNetworkLayer.request(request)
                if let items = items {
                    await store.updatePagesList(page, itemModel: items)
                }
            } catch {
                print(error)
            }
            state = .listing
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
    
    func backPage() {
        page = page > 2 ? page - 1 : 1
        self.fetchPage()
    }
    
    func tapAction(_ itemId: String) {
        let itemGroup = items?.items.filter({ $0.contains { $0.itemId == itemId } })
        selectedItem = itemGroup?.first?.first(where: { $0.itemId == itemId })
        otherItems = itemGroup?.first?.filter { $0.itemId != itemId }
    }
    
    func didSelectCategory(_ category: String) {
        self.selectedCategory = category
        self.showCategories = false
    }
}
