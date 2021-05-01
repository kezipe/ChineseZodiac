//
//  Person+Extensions.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation
import Zodiacs

extension Person {
  var zodiacSign: ChineseZodiac? {
    ChineseZodiac(date: self.birthdate)
  }
  
  var zodiacName: String? {
    zodiacSign?.description.capitalized
  }

  var isPlaceholder: Bool {
    birthdate == .distantPast
  }
}
