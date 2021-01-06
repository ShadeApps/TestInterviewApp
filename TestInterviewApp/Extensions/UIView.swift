//
//  UIView.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 03.01.2021.
//

import UIKit

extension UIView {
    
    func centerIn(_ parentView: UIView, size: CGSize? = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(self)
        
        guard let superview = superview else {
            return
        }
        
        if let size = size {
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: size.height),
                widthAnchor.constraint(equalToConstant: size.width)
            ])
        }
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
        
    }
    
    func addTo(parentView: UIView, useSafeAreaTop: Bool = false, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(self)
        
        guard let superview = superview else {
            return
        }
        
        let top = useSafeAreaTop ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: top),
            heightAnchor.constraint(equalToConstant: height),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor)
        ])
        
    }
    
    func addTo(parentView: UIView, below: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(self)
        
        guard let superview = superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: below.bottomAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
        
    }
    
    func fill(parentView: UIView, useSafeAreaTop: Bool = false) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(self)
        
        guard let superview = superview else {
            return
        }
        
        let top = useSafeAreaTop ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: top),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
        
    }
    
}

extension UIView {

    var heightConstraint: NSLayoutConstraint? {
        
        constraints.first(where: { constraint -> Bool in
            guard case .height = constraint.firstAttribute else {
                return false
            }

            return type(of: constraint) == NSLayoutConstraint.self
        })
        
    }

    var widthConstraint: NSLayoutConstraint? {
        
        constraints.first(where: { constraint -> Bool in
            guard case .width = constraint.firstAttribute else {
                return false
            }

            return type(of: constraint) == NSLayoutConstraint.self
        })
        
    }

    func autoresize() {
        
        let newSize = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        frame.size = newSize
        
    }

    func removeAllConstraints() {
        
        constraints.forEach { removeConstraint($0) }
        
    }
}
