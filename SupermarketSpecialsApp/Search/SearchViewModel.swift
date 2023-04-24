//
//  SearchViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//
import NetworkLayerSPM
import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var items: ItemsModel?
    @Published var query: String = "chocolate"
    @Published var isLoading = false
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
                    Task {
                        await self.search(query: value)
                    }
                }
            })
            .store(in: &cancellable)
            
    }
    
    func search(query: String) async {
        isLoading = true
        let request = NetworkLayerRequest(urlBuilder: EndpointUrls.search(newWorlsIds: ["89ba1656-0ad7-4af0-8694-08bf335e99b9"], packNSaveIds: ["21ecaaed-0749-4492-985e-4bb7ba43d59c"], query: query), httpMethod: .GET)
        do {
            items = try await NetworkLayer.defaultNetworkLayer.request(request)
            isLoading = false
        } catch {
            isLoading = false
            print(error)
        }
    }
}
