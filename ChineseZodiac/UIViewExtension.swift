//
//  UIViewExtension.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-06.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

extension UIView {
  func image() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
    guard let context = UIGraphicsGetCurrentContext() else {
      return UIImage()
    }
    layer.render(in: context)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  fileprivate func whitespaceString(font: UIFont = UIFont.systemFont(ofSize: 15), width: CGFloat) -> String {
    let kPadding: CGFloat = 20
    let mutable = NSMutableString(string: "")
    let attribute = [NSAttributedString.Key.font: font]
    while mutable.size(withAttributes: attribute).width < width - (2 * kPadding) {
      mutable.append(" ")
    }
    return mutable as String
  }
}
