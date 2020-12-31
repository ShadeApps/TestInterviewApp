//
//  NetworkError.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidEndpoint(endpoint: Any)
    
}
