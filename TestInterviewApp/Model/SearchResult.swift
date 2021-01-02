//
//  Item.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 29.12.2020.
//
import Foundation

struct SearchResult: Codable {

	let authors: [Author]?
	let bayesianAverageRating: Double?
	let cover: Cover?
	let descriptionField: String?
	let id: String?
	let language: Author?
	let narrators: [Author]?
	let orderInSeries: Int?
	let originalTitle: String?
	let parts: [Part]?
	let publishers: [Publisher]?
	let rating: Double?
	let resultType: String?
	let reviewCount: Int?
	let seasonNumber: String?
	let seriesId: String?
	let seriesInfo: String?
	let seriesName: String?
	let shareUrl: String?
	let tags: [String]?
	let title: String?
	let type: String?

}
