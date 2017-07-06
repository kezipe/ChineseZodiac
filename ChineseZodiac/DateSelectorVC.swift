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

    var day:Int?, month:Int?, year:Int?

    var dateComponentsSelectionMode: BirthdaySelectionView.DateComponentSelectionMode?
    
    var firstLoadedM = false
    var firstLoadedD = false
    var firstLoadedY = false
    
    override func viewDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        pickerView.reloadPickerView()
    }
    
    
    func updateUI() {
//        print("Day has \(firstLoadedD ? "" : "not ")been loaded.")
//        print("Month has \(firstLoadedD ? "" : "not ")been loaded.")
//        print("Year has \(firstLoadedD ? "" : "not ")been loaded.")
        let row: Int!
        print("DateSelector's self.month is \(String(describing: self.month))")
        switch dateComponentsSelectionMode! {
        case .monthMode:
            if !firstLoadedM {
                row = 4
                firstLoadedM = true
            } else {
                row = self.month! - 1
            }
        case .dayMode:
            if !firstLoadedD {
                row = 4
                firstLoadedD = true
            } else {
                row = self.day! - 1
            }
        case .yearMode:
            if !firstLoadedY {
                row = 2001
                firstLoadedY = true
            } else {
                row = self.year! - 1
            }
        }
        print("Row that's gonna be chosen is \(row)")
        pickerView.selectRow(row, animated: false)
    }
}

extension DateSelectorVC: PickerViewDataSource {
    
    func pickerView(_ pickerView: PickerView, titleForRow row: Int, index: Int) -> String {
        switch dateComponentsSelectionMode! {
        case .monthMode:
            return (index + 1).toMonthName()
        case .dayMode:
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
        case .yearMode:
            return "\(index + 1)"
        }
        
    }
    
    
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        switch dateComponentsSelectionMode! {
        case .monthMode:
            return 12
        case .dayMode:
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
        case .yearMode:
            return 2100
        }
        
    }
}

extension DateSelectorVC: PickerViewDelegate {
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: PickerView, didTapRow row: Int, index: Int) {
        handleSelection(index: index)
    }
    
    func handleSelection(index: Int) {
        switch dateComponentsSelectionMode! {
        case .monthMode:
            self.month = index + 1
        case .dayMode:
            self.day = index + 1
//            print("DateSelector's self.day is \(self.day ?? 0)")
        case .yearMode:
            self.year = index + 1
//            print("DateSelector's self.year is \(self.year ?? 0)")
        }
        dismiss(animated: true, completion: nil)
    }
}
