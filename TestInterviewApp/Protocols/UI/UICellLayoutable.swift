//
//  UICellLayoutable.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 05.01.2021.
//

import UIKit

public protocol UICellLayoutable: UITableViewCell {
    
    func addViews()
    func styleViews()
    
    
}
