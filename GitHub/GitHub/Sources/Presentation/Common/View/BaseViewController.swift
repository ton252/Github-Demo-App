//
//  ViewController.swift
//  GitHub
//
//  Created by Anton Polyakov on 08.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    struct KeyboardInfo {
        let frame: CGRect
        let curve: UIView.AnimationOptions
        let duration: TimeInterval
        let padding: CGFloat
    }
    
    var bindBottomToKeyboardFrame: NSLayoutConstraint? {
        return nil
    }
    
    func keyboardFrameWillChangeFrame(info: KeyboardInfo) {
        if let constraint = self.bindBottomToKeyboardFrame {
            self.bindBottomToKeyboardFrame(constraint, info: info)
        }
    }
    
    func keyboardFrameWillShow(info: KeyboardInfo) {
        //
    }
    
    func keyboardFrameWillHide(info: KeyboardInfo) {
        if let constraint = self.bindBottomToKeyboardFrame {
            self.bindBottomToKeyboardFrame(constraint, info: info)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Keyboard Binding

extension BaseViewController {
    
    func bindToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillChangeFrame),
                                               name: UIWindow.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: UIWindow.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIWindow.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unbindFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIWindow.keyboardWillChangeFrameNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIWindow.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIWindow.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    private func bindBottomToKeyboardFrame(_ bottomConstraint: NSLayoutConstraint, info: KeyboardInfo) {
        bottomConstraint.constant = info.padding
        
        var constraintView = bottomConstraint.firstItem as? UIView
        constraintView = constraintView ?? bottomConstraint.secondItem as? UIView
        
        guard let animateView = constraintView else { return }
        
        UIView.animate(
            withDuration: info.duration,
            delay: 0.0,
            options: info.curve,
            animations: {
                animateView.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func keyboardWillChangeFrame(notification: Notification) {
        guard let info = self.keyboardInfo(from: notification) else {
            return
        }
        self.keyboardFrameWillChangeFrame(info: info)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let info = self.keyboardInfo(from: notification) else {
            return
        }
        self.keyboardFrameWillShow(info: info)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let info = self.keyboardInfo(from: notification) else {
            return
        }
        self.keyboardFrameWillHide(info: info)
    }
    
    private func keyboardInfo(from notification: Notification) -> KeyboardInfo? {
        guard
            let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let curveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let durationValue = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
            else {
                return nil
        }
        
        let duration = TimeInterval(durationValue.doubleValue)
        let keyboardFrame = self.view.convert(keyboardFrameValue.cgRectValue, from: nil)
        let curve = UIView.AnimationOptions(rawValue: curveValue.uintValue)
        let padding = max(self.view.frame.height - keyboardFrame.minY, 0)
        
        return KeyboardInfo(frame: keyboardFrame, curve: curve, duration: duration, padding: padding)
    }
    
}
