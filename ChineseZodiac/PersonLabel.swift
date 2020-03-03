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
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byTruncatingMiddle
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.75
    return label
  }
}

extension UIImageView {
  static var zodiacImageView: UIImageView {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    if #available(iOS 13, *) {
      imageView.tintColor = .label
    } else {
      imageView.tintColor = .black
    }
    return imageView
  }
}
