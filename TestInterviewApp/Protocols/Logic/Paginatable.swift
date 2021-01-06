//
//  Paginatable.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 06.01.2021.
//

import UIKit

public protocol Paginatable: AnyObject {
    
    func didScroll(_ scrollView: UIScrollView)
    func resetCursor()
    
}
