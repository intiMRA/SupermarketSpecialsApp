//
//  EndpointUrls.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 19/04/23.
//

import Foundation
import NetworkLayerSPM

enum EndpointUrls: NetworkLayerURLBuilder {
    static let isDebug = true
    enum ParameterKeys {
        static let newWorlsIds = "newWorldIds"
        static let packNSaveIds = "packNSaveIds"
        static let query = "query"
    }
    
    case pages(newWorlsIds: [String], packNSaveIds: [String], pageNumber: Int)
    case search(newWorlsIds: [String], packNSaveIds: [String], query: String)
    case categories
    
    func url() -> URL? {
        var url: URL?
        var queryItems: [URLQueryItem] = []
        let baseUrl = "http://\(EndpointUrls.isDebug ? "localhost" : "3.25.252.179"):8080"
        switch self {
        case .pages(newWorlsIds: let newWorlsIds, packNSaveIds: let packNSaveIds, pageNumber: let pageNumber):
            let completeUrl = "\(baseUrl)/items/\(pageNumber)"
            url = URL(string: completeUrl)
            queryItems.append(URLQueryItem(name: ParameterKeys.newWorlsIds, value: newWorlsIds.joined(separator: ",")))
            queryItems.append(URLQueryItem(name: ParameterKeys.packNSaveIds, value: packNSaveIds.joined(separator: ",")))
        case .search(newWorlsIds: let newWorlsIds, packNSaveIds: let packNSaveIds, query: let query):
            let completeUrl = "\(baseUrl)/items/search"
            url = URL(string: completeUrl)
            queryItems.append(URLQueryItem(name: ParameterKeys.query, value: query))
            queryItems.append(URLQueryItem(name: ParameterKeys.newWorlsIds, value: newWorlsIds.joined(separator: ",")))
            queryItems.append(URLQueryItem(name: ParameterKeys.packNSaveIds, value: packNSaveIds.joined(separator: ",")))
        case .categories:
            let completeUrl = "\(baseUrl)/items/categoryNames"
            url = URL(string: completeUrl)
        }
        url?.append(queryItems: queryItems)
        return url
    }
}
