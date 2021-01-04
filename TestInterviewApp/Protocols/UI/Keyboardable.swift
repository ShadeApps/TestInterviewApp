//
//  Keyboardable.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 04.01.2021.
//

import Foundation

public protocol Keyboardable: AnyObject {
    
    var keyboardObserver: KeyboardObserver { get }

    func setupKeyboard()
    func keyboardObserving(start: Bool)
    
}
