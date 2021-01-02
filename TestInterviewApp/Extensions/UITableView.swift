//
//  UITableView.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 03.01.2021.
//

import UIKit

extension UITableView {
    
    func registerCell<CellClass: UITableViewCell>(_ cellClass: CellClass.Type) {
        
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
        
    }
    
    func dequeueReusableCell<CellClass: UITableViewCell>(withClass cellClass: CellClass.Type, for indexPath: IndexPath) -> CellClass {
        
        dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! CellClass
        
    }
    
}
