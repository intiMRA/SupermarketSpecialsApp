//
//  SearchViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//
import NetworkLayerSPM
import Foundation
import Combine

enum SearchViewModelState: String {
    case entry, loading, showingItems
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var items: ItemsModel?
    @Published var query: String = ""
    @Published var state: SearchViewModelState = .entry
    var selectedItem: ItemModel?
    var otherItems: [ItemModel]?
    
    private var cancellable = Set<AnyCancellable>()
    init() {
        $query
            .subscribe(on: DispatchQueue.main)
            .dropFirst()
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
            .sink(receiveValue: { value in
                if value.count > 3 {
                    self.state = .loading
                    Task {
                        await self.search(query: value)
                    }
                }
            })
            .store(in: &cancellable)
            
    }
    
    func search(query: String) async {
        state = .loading
        let request = NetworkLayerRequest(urlBuilder: EndpointUrls.search(newWorlsIds: ["89ba1656-0ad7-4af0-8694-08bf335e99b9"], packNSaveIds: ["21ecaaed-0749-4492-985e-4bb7ba43d59c"], query: query), httpMethod: .GET)
        do {
            items = try await NetworkLayer.defaultNetworkLayer.request(request)
        } catch {
            print(error)
        }
        state = .showingItems
    }
    
    func tapAction(_ itemId: String) {
        let itemGroup = items?.items.filter({ $0.contains { $0.itemId == itemId } })
        selectedItem = itemGroup?.first?.first(where: { $0.itemId == itemId })
        otherItems = itemGroup?.first?.filter { $0.itemId != itemId }
    }
}
