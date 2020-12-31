//
//  EndpointTest.swift
//  TestInterviewAppTests
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import XCTest
@testable import TestInterviewApp

private enum Constants {
    static let httpMethod = HTTPMethod.post
    static let path = "test"
}

class EndpointTest: XCTestCase {
    
    typealias StubbedEndpoint = Endpoint<EndpointTypes.Stub, String>
    let endpoint = StubbedEndpoint(path: Constants.path, method: Constants.httpMethod)
    
    
    func testEndpointCreate() throws {
        let request = endpoint.create(with: "")
        XCTAssertEqual(
            request?.url?.absoluteString,
            "\(NetworkState.current.scheme)://\(NetworkState.current.host)/\(Constants.path)?"
        )
    }
    
    func testEndpointMethod() throws {
        let request = endpoint.create(with: "")
        XCTAssertEqual(
            request?.httpMethod,
            Constants.httpMethod.rawValue
        )
    }
    
}
