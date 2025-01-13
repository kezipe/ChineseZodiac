//
//  UIViewControllerExtension.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-04.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(
                target: self,
                action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
