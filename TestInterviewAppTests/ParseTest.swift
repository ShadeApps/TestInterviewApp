//
//  ParseTest.swift
//  TestInterviewAppTests
//
//  Created by Sergey Grischyov on 29.12.2020.
//

import XCTest
@testable import TestInterviewApp

class ParseTest: XCTestCase {

    func testParser() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "MockData", withExtension: "json") else {
            XCTFail("Missing file: MockData.json")
            return
        }

        let json = try Data(contentsOf: url)
        let response: SearchResponse = try JSONDecoder().decode(SearchResponse.self, from: json)

        XCTAssertEqual(response.query, "harry")
        XCTAssertNotNil(response.items)
    }

}
