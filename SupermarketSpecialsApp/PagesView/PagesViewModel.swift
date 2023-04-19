//
//  PagesViewModel.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//
import NetworkLayerSPM

struct Item: Codable {
    let brand: String
    let category: String
    let itemId: String
    let name: [String]
    let photoUrl: [String]
    let price: [String]
    let size: [String]
    let supermarket: String
}

struct Items: Codable {
    let items: [[Item]]
}

import Foundation
@MainActor
class PagesViewModel: ObservableObject {
    @Published var items: Items?
    
    func fetchPage() async {
        let request = NetworkLayerRequest(urlBuilder: EndpointUrls.pages(newWorlsIds: ["60928d93-06fa-4d8f-92a6-8c359e7e846d"], packNSaveIds: ["3e82142c-78dc-46f3-82ec-28e65fcf84c9"], pageNumber: 18), httpMethod: .GET)
        do {
            items = try await NetworkLayer.defaultNetworkLayer.request(request)
        } catch {
            print(error)
        }
    }
}
