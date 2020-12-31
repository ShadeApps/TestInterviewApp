//
//  Endpoints.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation

extension Endpoint where Type == EndpointTypes.Public, Response == SearchResponse {
    
    static func search(for query: String, next page: String?) -> Self {
        var items = [URLQueryItem(name: "query", value: query)]
        if page.isSome {
            items.append(URLQueryItem(name: "page", value: page))
        }
        return Endpoint(path: "search", method: .get, ulrQueryItems: items)
    }
    
}
