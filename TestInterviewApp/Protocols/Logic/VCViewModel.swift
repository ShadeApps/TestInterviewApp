//
//  VCViewModel.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 05.01.2021.
//

import Foundation

public protocol VCViewModel {
    
    func numberOfElements() -> Int
    func elementAtIndex(_ index: IndexPath) -> ElementViewModel?
    
    mutating func setElements(_ array: [ElementViewModel])
    mutating func appendElements(_ array: [ElementViewModel])
    
}
