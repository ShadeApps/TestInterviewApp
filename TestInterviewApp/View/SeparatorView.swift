//
//  SeparatorView.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 03.01.2021.
//

import UIKit

final class SeparatorView: UIView {

    override func layoutSubviews() {
        
        super.layoutSubviews()

        let layoutConstraint: NSLayoutConstraint! = {
            if bounds.width > bounds.height {
                return heightConstraint
            } else if bounds.height > bounds.width {
                return widthConstraint
            }

            return nil
        }()

        guard layoutConstraint.isSome else {
            return
        }

        let separatorHeight = 1.0 / UIScreen.main.scale
        
        if layoutConstraint.constant != separatorHeight {
            layoutConstraint.constant = separatorHeight
        }
        
        backgroundColor = .lightGray
        
    }
    
}
