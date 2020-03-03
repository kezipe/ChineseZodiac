//
//  PersonLabel.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-03-02.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

extension UILabel {
  static var personLabel: UILabel {
    let label = UILabel()
    if #available(iOS 13, *) {
      label.textColor = .secondaryLabel
    } else {
      label.textColor = .gray
    }
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byTruncatingMiddle
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.85
    return label
  }
}

extension UIImageView {
  static var zodiacImageView: UIImageView {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    if #available(iOS 13, *) {
      imageView.tintColor = .secondaryLabel
    } else {
      imageView.tintColor = .black
    }
    return imageView
  }
}
