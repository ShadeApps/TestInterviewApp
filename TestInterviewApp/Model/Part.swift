//
//  Part.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 29.12.2020.
//

import Foundation

struct Part: Codable {

	let cover: Cover?
	let descriptionField: String?
	let episodeNumber: Int?
	let formatAvailability: String?
	let formats: [Format]?
	let id: String?
	let title: String?

}
