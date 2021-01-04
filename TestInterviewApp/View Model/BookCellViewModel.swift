//
//  BookCellViewModel.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 05.01.2021.
//

import Foundation

struct BookCellViewModel: ElementViewModel {
    
    let title: String
    let byAuthors: String
    let withNarrators: String
    let coverURL: URL?
    
    init(searchResult: SearchResult) {
        
        self.title = searchResult.title ?? ""
        self.byAuthors = searchResult.authors?.compactMap({ $0.name ?? "" }).joined(separator: ", ") ?? ""
        self.withNarrators = searchResult.narrators?.compactMap({ $0.name ?? "" }).joined(separator: ", ") ?? ""
        self.coverURL = searchResult.cover?.url
        
    }
    
}
