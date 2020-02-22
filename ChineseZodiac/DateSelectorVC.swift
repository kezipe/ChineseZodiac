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

    var delegate: PickerViewDelegate!
    var dateComponents: DateComponents!

    var dateComponentsSelectionMode: DateComponentSelectionMode?
    
    override func viewDidLoad() {
        pickerView.dataSource = self
        pickerView.delegate = delegate
        pickerView.backgroundColor = Helper.color
        pickerView.tintColor = Helper.color2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    
    func updateUI() {
        let row: Int!
        switch dateComponentsSelectionMode! {
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

extension DateSelectorVC: PickerViewDataSource {
    func pickerView(_ pickerView: PickerView, titleForRow row: Int) -> String {
        let index = row
        
        switch dateComponentsSelectionMode! {
        case .month:
            return (index + 1).toMonthName()
        case .day:
            let month: Int!
            if let months = dateComponents.month {
                month = months
            } else {
                month = 1
            }
            let yearCheck: Int!
            if let years = dateComponents.year {
                yearCheck = years
            } else {
                yearCheck = 2000
            }
            let indices = [Int](1...month.toNumDaysInMonth(year: yearCheck))
            return "\(indices[index])"
        case .year:
            return "\(index + 1)"
        }
    }
    
    
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        switch dateComponentsSelectionMode! {
        case .month:
            return 12
        case .day:
            if let months = dateComponents.month {
                let yearCheck: Int!
                if let years = dateComponents.year {
                    yearCheck = years
                } else {
                    yearCheck = 2000
                }
                return months.toNumDaysInMonth(year: yearCheck)
            } else {
                return 31
            }
        case .year:
            return 2100
        }
        
    }
}


