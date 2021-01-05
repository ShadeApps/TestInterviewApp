//
//  BookCellViewModel.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 05.01.2021.
//

import Foundation

struct BookCellViewModel: ElementViewModel {
    
    private enum Constants {
        static let defaultCoverURL = URL(string: "https://investors.storytel.com/en/wp-content/themes/storytel/assets/images/logo.png")!
    }
    
    let title: String
    let byAuthors: String
    let withNarrators: String
    let coverURL: URL
    
    init(searchResult: SearchResult) {
        
        title = searchResult.title ?? ""
        
        let by = searchResult.authors?.compactMap({ $0.name ?? "" }).joined(separator: ", ") ?? ""
        byAuthors = by.isEmpty ? "" : Localized.by + by
        
        let with = searchResult.narrators?.compactMap({ $0.name ?? "" }).joined(separator: ", ") ?? ""
        withNarrators = with.isEmpty ? "" : Localized.with + with
        
        coverURL = searchResult.cover?.url ?? Constants.defaultCoverURL
        
    }
    
}
