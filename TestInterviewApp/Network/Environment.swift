//
//  Environment.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation

enum Environment {
    
    private enum Constants {
        static let schemeHTTP = "http"
        static let schemeHTTPS = "https"
        static let hostDevelopment = "api.storytel.net"
        static let defaultHost = "api.storytel.com"
    }

    case development
    case production

    var scheme: String {
        
        switch self {
        case .development:
            return Constants.schemeHTTPS
        default:
            return Constants.schemeHTTP
        }
        
    }

    var host: String {
        
        switch self {
        case .development:
            return Constants.hostDevelopment
        default:
            return Constants.defaultHost
        }
        
    }
    
}
