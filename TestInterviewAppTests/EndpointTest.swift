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
    static let paramName = "param"
    static let paramName2 = "value"
    static let paramValue = "newParam"
    static let paramValue2 = "value2"
}

class EndpointTest: XCTestCase {
    
    typealias StubbedEndpoint = Endpoint<EndpointTypes.Stub, String>
    let endpoint = StubbedEndpoint(path: Constants.path, method: Constants.httpMethod)
    let absoluteURLString = "\(NetworkState.current.scheme)://\(NetworkState.current.host)/\(Constants.path)?"
    
    func testEndpointCreate() {
        
        let request = endpoint.create(with: "")
        
        XCTAssertEqual(
            request?.url?.absoluteString,
            absoluteURLString
        )
        
    }
    
    func testEndpointHTTPMethod() {
        
        let request = endpoint.create(with: "")
        
        XCTAssertEqual(
            request?.httpMethod,
            Constants.httpMethod.rawValue
        )
        
    }
    
    func testQueryItems() {
        
        let endpoint = StubbedEndpoint(path: Constants.path,
                                       method: Constants.httpMethod,
                                       ulrQueryItems: [
                                        URLQueryItem(name: Constants.paramName,
                                                     value: Constants.paramValue),
                                        URLQueryItem(name: Constants.paramName2,
                                                     value: Constants.paramValue2)
                                       ])
        
        let request = endpoint.create(with: "")
        
        XCTAssertEqual(
            request?.url?.absoluteString,
            absoluteURLString +
                "\(Constants.paramName)=\(Constants.paramValue)&\(Constants.paramName2)=\(Constants.paramValue2)"
        )
        
    }
    
}
