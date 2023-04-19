//
//  EndpointUrls.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//

import Foundation
import NetworkLayerSPM

enum EndpointUrls: NetworkLayerURLBuilder {
    enum ParameterKeys {
        static let newWorlsIds = "newWorldIds"
        static let packNSaveIds = "packNSaveIds"
    }
    
case pages(newWorlsIds: [String], packNSaveIds: [String], pageNumber: Int)
    func url() -> URL? {
        var url: URL?
        var queryItems: [URLQueryItem] = []
        switch self {
        case .pages(newWorlsIds: let newWorlsIds, packNSaveIds: let packNSaveIds, pageNumber: let pageNumber):
            let baseUrl = "http://3.25.252.179:8080/items/\(pageNumber)"
            url = URL(string: baseUrl)
            queryItems.append(URLQueryItem(name: ParameterKeys.newWorlsIds, value: newWorlsIds.joined(separator: ",")))
            queryItems.append(URLQueryItem(name: ParameterKeys.packNSaveIds, value: packNSaveIds.joined(separator: ",")))
        }
        url?.append(queryItems: queryItems)
        return url
    }
}
