//
//  DateSelectorVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-04.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class DateSelectorVC: UIViewController {
    @IBOutlet weak var pickerView: PickerView!

    var day: Int?, month: Int?, year: Int?
    var delegate: PickerViewDelegate!

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
            if month == nil {
                row = 0
            } else {
                row = self.month! - 1
            }
        case .day:
            if day == nil {
                row = 0
            } else {
                row = self.day! - 1
            }
        case .year:
            if year == nil {
                row = 1999
            } else {
                row = self.year! - 1
            }
        }
        pickerView.selectRow(row, animated: false)
        pickerView.reloadPickerView()
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
            if let months = self.month {
                month = months
            } else {
                month = 1
            }
            let yearCheck: Int!
            if let years = self.year {
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
            if let months = self.month {
                let yearCheck: Int!
                if let years = self.year {
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


