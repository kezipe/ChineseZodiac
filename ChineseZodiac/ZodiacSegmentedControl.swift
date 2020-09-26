//
//  ZodiacSegmentedControl.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-09-25.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

final class ZodiacSegmentedControl: UISegmentedControl {
  // MARK: Private Types
  private enum Selection: String, CaseIterable {
    case name, zodiac, birthday, created
  }
  // MARK: API Variables
  // MARK: Private Variables
  // MARK: API Functions
  // MARK: Private Functions
  
  // MARK: Initializers
  convenience init() {
    let selection = Selection.allCases.map(\.rawValue.capitalized)
    self.init(items: selection)
    translatesAutoresizingMaskIntoConstraints = false
  }
}
