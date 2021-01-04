//
//  Loadable.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 04.01.2021.
//

import Foundation

public protocol Loadable: AnyObject {
    
    var dataProvider: Providable { get set }
    var isLoadingData: Bool { get set }

    func loadData(animated: Bool)
    func didLoadData()
    func displayLoadError(_ error: Error)
}
