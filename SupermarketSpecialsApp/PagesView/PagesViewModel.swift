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
    let name: String
    let photoUrl: String
    let price: String
    let size: String
    let supermarket: String
    let supermarketId: String?
}

struct Items: Codable {
    let items: [[Item]]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let items = try container.decode([[Item]].self, forKey: .items)
        self.items = items.map({ itemGroup in
            itemGroup.map { item in
                    .init(brand: item.brand,
                          category: item.category,
                          itemId: UUID().uuidString,
                          name: item.name,
                          photoUrl: item.photoUrl,
                          price: item.price,
                          size: item.size,
                          supermarket: item.supermarket,
                          supermarketId: item.supermarketId)
            }
        })
    }
}

import Foundation
@MainActor
class PagesViewModel: ObservableObject {
    @Published var items: Items?
    
    func fetchPage() async {
        let request = NetworkLayerRequest(urlBuilder: EndpointUrls.pages(newWorlsIds: ["421d563e-ce40-4d5c-a79c-4afb521fc5b0"], packNSaveIds: ["e1925ea7-01bc-4358-ae7c-c6502da5ab12"], pageNumber: 2), httpMethod: .GET)
        do {
            items = try await NetworkLayer.defaultNetworkLayer.request(request)
        } catch {
            print(error)
        }
    }
}
