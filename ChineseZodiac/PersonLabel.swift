//
//  PersonLabel.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-03-02.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

final class PersonLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    lineBreakMode = .byTruncatingMiddle
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.75
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
