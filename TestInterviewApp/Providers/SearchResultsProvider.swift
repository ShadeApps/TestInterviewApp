//
//  SearchResultsProvider.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation
import Combine

struct SearchResultsProvider {
    
    var urlSession = URLSession.shared
    
    func loadResults(matching query: String, next page: String?) -> AnyPublisher<SearchResponse, Error> {
        urlSession.combinePublisher(
            for: .search(for: query, next: page), using: ()
        )
    }
    
}
