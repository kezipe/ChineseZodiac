//
//  BirthdaySelectionViewPickerViewDelegate.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-21.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class BirthdaySelectionViewPickerViewDelegate: PickerViewDelegate {
  
  private let PICKERVIEW_TEXT_COLOR = UIColor(red: 233.0/255, green: 160.0/255, blue: 52.0/255, alpha: 1.0)
  private let PICKERVIEW_TEXT_FONT = "HelveticaNeue-Light"
  weak var parentController: DatePickable?
  
  func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
    return 50.0
  }
  
  func pickerView(_ pickerView: PickerView, didTapRow row: Int) {
    parentController?.didTapRow(at: row)
  }
  
  func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
    label.textAlignment = .center
    label.textColor = PICKERVIEW_TEXT_COLOR
    
    if highlighted {
      label.font = UIFont(name: PICKERVIEW_TEXT_FONT, size: 30)
    } else {
      label.font = UIFont(name: PICKERVIEW_TEXT_FONT, size: 20)
    }
  }
}
