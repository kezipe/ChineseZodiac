//
//  DateSelectorVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-04.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class DateSelectorVC: UIViewController {
  @IBOutlet weak var pickerView: PickerView!
  
  var dateComponents: DateComponents! {
    didSet {
      dataSource.dateComponentsSelected = dateComponents
    }
  }
  weak var parentController: DatePickable?
  private var delegate = DateSelectorVCDelegate()
  private var dataSource = DateSelectorVCDataSource()
  
  var dateComponentsSelectionMode: DateComponentSelectionMode = .month {
    didSet {
      dataSource.dateComponentsSelectionMode = dateComponentsSelectionMode
      delegate.dateComponentSelectionMode = dateComponentsSelectionMode
    }
  }
  
  override func viewDidLoad() {
    dataSource.dateComponentsSelectionMode = dateComponentsSelectionMode
    pickerView.dataSource = dataSource

    delegate.parentController = parentController
    pickerView.delegate = delegate
    pickerView.backgroundColor = Helper.color
    pickerView.tintColor = Helper.color2
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateUI()
  }
  
  
  func updateUI() {
    let row: Int!
    switch dateComponentsSelectionMode {
    case .month:
      if let month = dateComponents.month {
        row = month - 1
      } else {
        row = 0
      }
    case .day:
      if let day = dateComponents.day {
        row = day - 1
      } else {
        row = 0
      }
    case .year:
      if let year = dateComponents.year {
        row = year - 1
      } else {
        row = 1999
      }
    }
    pickerView.reloadPickerView()
    pickerView.selectRow(row, animated: false)
  }
}


