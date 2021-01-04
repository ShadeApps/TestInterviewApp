//
//  SearchResultsProvider.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation
import Combine

typealias SearchProviderResult = Result<SearchResponse, Error>

class SearchResultsProvider: Providable {
    
    var urlSession = URLSession.shared
    private var publisher: AnyCancellable?
    
    // MARK: - Loading Data
    
    func loadResults(matching query: String, next page: String?, completion: @escaping (SearchProviderResult) -> Void) {
        //Combine is best enjoyed with Swift UI so we use a proxy to
        //traditional callback while also obscuring Combine inside our provider
        
        publisher = urlSession.combinePublisher(
            for: .search(for: query, next: page), using: ()
        ).sink { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            default:
                break
            }
        } receiveValue: { data in
            completion(.success(data))
        }
        
    }
    
}

extension Providable {
    
    func loadResults(matching query: String,
                     next page: String?,
                     completion: @escaping (SearchProviderResult) -> Void) { }
    
}
