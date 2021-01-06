//
//  Item.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 29.12.2020.
//
import Foundation

struct SearchResult: Codable {

	let authors: [Author]?
	let cover: Cover?
	let descriptionField: String?
	let id: String?
	let language: Author?
	let narrators: [Author]?
	let orderInSeries: Int?
	let originalTitle: String?
	let title: String?
	let type: String?

}
