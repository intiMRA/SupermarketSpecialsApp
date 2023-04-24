//
//  SearchViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 24/04/23.
//
import NetworkLayerSPM
import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var items: ItemsModel?
    @Published var query = "milk"
    
    func search() async {
        let request = NetworkLayerRequest(urlBuilder: EndpointUrls.search(newWorlsIds: ["89ba1656-0ad7-4af0-8694-08bf335e99b9"], packNSaveIds: ["21ecaaed-0749-4492-985e-4bb7ba43d59c"], query: query), httpMethod: .GET)
        do {
            items = try await NetworkLayer.defaultNetworkLayer.request(request)
        } catch {
            print(error)
        }
    }
}
