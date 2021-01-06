//
//  MainVCViewModel.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 05.01.2021.
//

import Foundation

struct MainVCViewModel: VCViewModel {
    
    var searchQuery = ""
    var nextPage: String?
    
    private var elements = [ElementViewModel]()
    
    func numberOfElements() -> Int {
        
        elements.count
        
    }
    
    func elementAtIndex(_ index: IndexPath) -> ElementViewModel? {
        
        elements[safe: index.row]
    }
    
    
    mutating func setElements(_ array: [ElementViewModel]) {
        
        elements = array
        insertLoaderIfNeeded()
        
    }
    
    mutating func appendElements(_ array: [ElementViewModel]) {
        
        elements.append(contentsOf: array)
        insertLoaderIfNeeded()
        
    }
    
    private mutating func insertLoaderIfNeeded() {
        
        guard !elements.isEmpty else {
            return
        }
        
        elements.removeAll(where: { $0 is LoaderCellViewModel})
        
        if let next = nextPage, !next.isEmpty {
            
            elements.append(LoaderCellViewModel())
            
        }
        
    }
    
}
