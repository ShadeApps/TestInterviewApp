//
//  Format.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 29.12.2020.
//

import Foundation

struct Format: Codable {

	let abridged: Bool?
	let audioAssets: [AudioAsset]?
	let bookSource: String?
	let cdnLink: String?
	let cdnType: String?
	let chapterCount: Int?
	let cover: Cover?
	let edition: String?
	let enterServiceDate: String?
	let id: String?
	let isReleased: Bool?
	let isbn: String?
	let length: Int?
	let releaseDate: String?
	let searchable: Bool?
	let type: String?

}
