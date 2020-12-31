//
//  Endpoint.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation

struct Endpoint<Type: EndpointType, Response: Decodable> {
    
    var path: String
    var method: HTTPMethod
    var ulrQueryItems = [URLQueryItem]()
    
}

protocol EndpointType {
    
    associatedtype RequestData
    
    static func setUp(_ request: inout URLRequest, with data: RequestData, method: HTTPMethod)
    
}

enum EndpointTypes {
    
    enum Public: EndpointType {
        static func setUp(_ request: inout URLRequest, with _: Void, method: HTTPMethod) {
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.httpMethod = method.rawValue
        }
    }
    
    enum Private: EndpointType {
        static func setUp(_ request: inout URLRequest, with token: String, method: HTTPMethod) {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = method.rawValue
        }
    }
    
}

extension EndpointTypes {
    enum Stub: EndpointType {
        static func setUp(_ request: inout URLRequest, with token: String, method: HTTPMethod) {
            request.httpMethod = method.rawValue
        }
    }
}

extension Endpoint {
    
    func create(with data: Type.RequestData) -> URLRequest? {
        var components = URLComponents()
        components.scheme = NetworkState.current.scheme
        components.host = NetworkState.current.host
        components.path = "/" + path
        components.queryItems = ulrQueryItems
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        Type.setUp(&request, with: data, method: method)
        return request
    }
    
}
