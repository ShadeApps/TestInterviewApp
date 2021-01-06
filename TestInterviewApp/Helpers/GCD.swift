//
//  GCD.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 06.01.2021.
//

import Foundation

func doAfter(_ delay: TimeInterval? = nil, _ closure: @escaping () -> Void) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + (delay ?? 0), execute: closure)
    
}
