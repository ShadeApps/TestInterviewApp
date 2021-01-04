//
//  Localization.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 04.01.2021.
//

import Foundation

func LOC(_ key: String) -> String {
    
    NSLocalizedString(key, comment: "")
    
}

struct Localized {
    static let by  = LOC("by")
    static let with  = LOC("with")
    static let search  = LOC("search")
}
