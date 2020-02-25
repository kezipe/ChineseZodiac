//
//  Person+Extensions.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation

extension Person {
  var zodiacSign: Zodiac {
    guard 1...12 ~= self.zodiac else {
      fatalError("Non-existent zodiac sign")
    }
    return Zodiac(rawValue: Int(self.zodiac) - 1)!
  }
}
