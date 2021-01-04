//
//  Optional.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 31.12.2020.
//

import Foundation

extension Optional {

    var isNone: Bool {
        
        if case .none = self {
            return true
        }

        return false
        
    }

    var isSome: Bool {
        
        if case .some = self {
            return true
        }

        return false
        
    }
}

extension Optional where Wrapped == String {

    var isEmptyOrNil: Bool {
        
        self?.isEmpty ?? true
        
    }

    var anyString: String {
        
        switch self {
        case .some(let unwrapped):
            return unwrapped
        case .none:
            return ""
        }
        
    }

    func or(value: String) -> String {
        
        switch self {
        case .some(let unwrapped):
            return unwrapped
        case .none:
            return value
        }
        
    }
}

extension Optional where Wrapped: Collection {

    var isEmptyOrNil: Bool {
        
        self?.isEmpty ?? true
        
    }

}
