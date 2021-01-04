//
//  BookTableCell.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 03.01.2021.
//

import UIKit

class BookTableCell: UITableViewCell {
    
    private enum Constants {
        static let leftOffset = CGFloat(10)
        static let defaultSpearatorHeight = CGFloat(1)
    }
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        addViews()
        styleViews()
        
    }
    
    func layoutWith(_ result: BookCellViewModel) {
        
    }
}

extension BookTableCell: UICellLayoutable {
    
    internal func addViews() {
        
        let separator = SeparatorView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: Constants.defaultSpearatorHeight),
            separator.leftAnchor.constraint(equalTo: separator.superview!.leftAnchor, constant: Constants.leftOffset),
            separator.rightAnchor.constraint(equalTo: separator.superview!.rightAnchor),
            separator.bottomAnchor.constraint(equalTo: separator.superview!.bottomAnchor)
        ])
        
    }
    
    internal func styleViews() {
        
        selectionStyle = .none
        
    }
    
}
