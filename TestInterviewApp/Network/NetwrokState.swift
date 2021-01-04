//
//  NetwrokState.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation

enum NetworkState {
    
    static var current: Environment {
        
        #if DEBUG
            return Environment.development
        #else
            return Environment.production
        #endif
        
    }
    
}
