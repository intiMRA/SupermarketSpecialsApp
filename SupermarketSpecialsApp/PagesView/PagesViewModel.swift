//
//  PagesViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//
import NetworkLayerSPM
import Foundation

@MainActor
class PagesViewModel: ObservableObject {
    @Published var items: ItemsModel?
    @Published var page = 1
    
    var selectedItem: ItemModel?
    var otherItems: [ItemModel]?
    
    func fetchPage() async {
        let request = NetworkLayerRequest(urlBuilder: EndpointUrls.pages(newWorlsIds: ["89ba1656-0ad7-4af0-8694-08bf335e99b9"], packNSaveIds: ["21ecaaed-0749-4492-985e-4bb7ba43d59c"], pageNumber: page), httpMethod: .GET)
        do {
            items = try await NetworkLayer.defaultNetworkLayer.request(request)
        } catch {
            print(error)
        }
    }
    
    func nextPage() async {
        page += 1
        await self.fetchPage()
    }
    
    func tapAction(_ itemId: String) {
        let itemGroup = items?.items.filter({ $0.contains { $0.itemId == itemId } })
        selectedItem = itemGroup?.first?.first(where: { $0.itemId == itemId })
        otherItems = itemGroup?.first?.filter { $0.itemId != itemId }
    }
}
