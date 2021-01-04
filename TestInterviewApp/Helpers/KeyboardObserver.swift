//
//  KeyboardObserver.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 04.01.2021.
//

import UIKit

public typealias KeyboardCallback = (KeyboardOptions) -> Void

public enum KeyboardEvent {
    
    case willShow
    case willHide
    case willChangeFrame
    
}

public struct KeyboardOptions {
    
    public let frame: CGRect

    public let animationCurve: UIView.AnimationCurve

    public let animationDuration: Double

    public var animationOptions: UIView.AnimationOptions {
        
        switch self.animationCurve {
        case UIView.AnimationCurve.easeIn:
            return UIView.AnimationOptions.curveEaseIn
        case UIView.AnimationCurve.easeInOut:
            return UIView.AnimationOptions.curveEaseInOut
        case UIView.AnimationCurve.easeOut:
            return UIView.AnimationOptions.curveEaseOut
        case UIView.AnimationCurve.linear:
            return UIView.AnimationOptions.curveLinear
        @unknown default:
            return UIView.AnimationOptions.curveLinear
            
        }
    }
}

public final class KeyboardObserver {

    private var callbacks: [KeyboardEvent: KeyboardCallback] = [:]

    // MARK: - Lifecycle
    public init() {}

    public func start() {
        
        let center = NotificationCenter.default

        for event in callbacks.keys {
            center.addObserver(self, selector: event.selector, name: event.notification, object: nil)
        }
        
    }

    public func stop() {
        
        let center = NotificationCenter.default
        center.removeObserver(self)
        
    }

    deinit {
        
        stop()
        
    }

    @discardableResult
    public func on(event: KeyboardEvent, do callback: KeyboardCallback?) -> Self {
        
        callbacks[event] = callback
        return self
        
    }
    
    // MARK: - Getting keyboardOptions from notifications
    private func keyboardOptions(fromNotificationDictionary userInfo: [AnyHashable: Any]?) -> KeyboardOptions {

        var frame = CGRect()
        if let value = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            frame = value
        }

        var animationCurve = UIView.AnimationCurve.linear
        if let index = (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            let value = UIView.AnimationCurve(rawValue: index) {
            animationCurve = value
        }

        var animationDuration: Double = 0.0
        if let value = (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            animationDuration = value
        }

        return KeyboardOptions(frame: frame, animationCurve: animationCurve, animationDuration: animationDuration)
        
    }

    // MARK: - UIKit notification handling
    @objc internal func keyboardWillShow(note: Notification) {
        
        callbacks[.willShow]?(keyboardOptions(fromNotificationDictionary: note.userInfo))
        
    }

    @objc internal func keyboardWillHide(note: Notification) {
        
        callbacks[.willHide]?(keyboardOptions(fromNotificationDictionary: note.userInfo))
        
    }

    @objc internal func keyboardWillChangeFrame(note: Notification) {
        
        callbacks[.willChangeFrame]?(keyboardOptions(fromNotificationDictionary: note.userInfo))
        
    }
}

private extension KeyboardEvent {
    
    // MARK: - Converting to internal types
    var notification: NSNotification.Name {
        
        switch self {
        case .willShow:
            return UIResponder.keyboardWillShowNotification
        case .willHide:
            return UIResponder.keyboardWillHideNotification
        case .willChangeFrame:
            return UIResponder.keyboardWillChangeFrameNotification
        }
        
    }

    var selector: Selector {
        
        switch self {
        case .willShow:
            return #selector(KeyboardObserver.keyboardWillShow(note:))
        case .willHide:
            return #selector(KeyboardObserver.keyboardWillHide(note:))
        case .willChangeFrame:
            return #selector(KeyboardObserver.keyboardWillChangeFrame(note:))
        }
        
    }
}
