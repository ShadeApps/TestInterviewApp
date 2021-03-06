//
//  SearchResultsProvider.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation
import Combine

typealias SearchProviderResult = Result<SearchResponse, Error>

final class SearchResultsProvider: Providable {
    
    var urlSession = URLSession.shared
    private var cancellable: AnyCancellable?
    
    // MARK: - Loading Data
    
    func loadResults(matching query: String, next page: String?, completion: @escaping (SearchProviderResult) -> Void) {
        //Combine is best enjoyed with Swift UI so we use a proxy to
        //traditional callback while also obscuring Combine inside our provider to easily manage this dependency
        
        cancellable = urlSession.combinePublisher(
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

private extension Providable {
    
    func loadResults(matching query: String,
                     next page: String?,
                     completion: @escaping (SearchProviderResult) -> Void) { }
    
}
