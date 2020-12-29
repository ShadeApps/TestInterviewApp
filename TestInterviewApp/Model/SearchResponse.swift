//
//  SearchResponse.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 29.12.2020.
//

import Foundation

struct SearchResponse: Codable {
    
	let filter: String?
	let filterOptions: String?
	let items: [Item]?
	let nextPageToken: String?
	let query: String?
	let totalCount: Int?
    
}
