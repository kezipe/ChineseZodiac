//
//  DateSelectorVCDelegate.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-21.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class DateSelectorVCDelegate: PickerViewDelegate {
  weak var parentController: DatePickable?
  var dateComponentSelectionMode: DateComponentSelectionMode = .day
  
  func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
    return 50.0
  }
  
  func pickerView(_ pickerView: PickerView, didTapRow row: Int) {
    parentController?.selectRow(at: row, mode: dateComponentSelectionMode)
  }

  func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
    label.textAlignment = .center
    label.textColor = Helper.PICKERVIEW_TEXT_COLOR
    
    if highlighted {
      label.font = UIFont(name: Helper.PICKERVIEW_TEXT_FONT, size: 30)
    } else {
      label.font = UIFont(name: Helper.PICKERVIEW_TEXT_FONT, size: 20)
    }
  }
}
