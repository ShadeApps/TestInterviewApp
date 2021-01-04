//
//  UILoadable.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 04.01.2021.
//

import UIKit

public protocol UILoadable: AnyObject {
    
    var centralLoader: UIActivityIndicatorView { get set }
    var isLoadingData: Bool { get set }

    func showLoader(_ show: Bool)
    
}
