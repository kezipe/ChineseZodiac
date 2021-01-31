//
//  UIColor+Convenience.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2021-01-31.
//  Copyright © 2021 Monorail Apps. All rights reserved.
//

import UIKit

extension UIColor {
  static let accentColor: UIColor = {
    if #available(iOS 11.0, *) {
      return UIColor(named: "AccentColor")!
    } else {
      return #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
    }
  }()
}
