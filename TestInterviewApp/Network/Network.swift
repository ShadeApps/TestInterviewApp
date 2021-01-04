//
//  Network.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 25.12.2020.
//

import Foundation
import Combine

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

extension URLSession {
    
    func combinePublisher<T, R>(for endpoint: Endpoint<T, R>,
                                using requestData: T.RequestData) -> AnyPublisher<R, Error> {
        
        guard let request = endpoint.create(with: requestData) else {
            return Fail(
                error: NetworkError.invalidEndpoint(endpoint: endpoint)
            ).eraseToAnyPublisher()
        }

        return dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: R.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
}
