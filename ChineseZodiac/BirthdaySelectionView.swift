//
//  BirthdaySelectionView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

enum DateComponentSelectionMode: String {
    case day = "Day", month = "Month", year = "Year"
}

class BirthdaySelectionView: UIViewController, UITextFieldDelegate {
    //  https://www.timeanddate.com/calendar/about-chinese.html
    
    var month: Int? = nil {
        didSet {
            updateLabel(monthLbl, newValue: month, mode: .month)
        }
    }
    var day: Int? = nil {
        didSet {
            updateLabel(dayLbl, newValue: day, mode: .day)
        }
    }
    var year: Int? = nil {
        didSet {
            updateLabel(yearLbl, newValue: year, mode: .year)
        }
    }
    
    func updateLabel(_ label: UIButton, newValue: Int?, mode: DateComponentSelectionMode) {
        if let newValue = newValue {
            if mode == .month {
                label.setTitle(newValue.toMonthName(), for: .normal)
            } else {
                label.setTitle("\(newValue)", for: .normal)
            }
        } else {
            label.setTitle(mode.rawValue, for: .normal)
            label.setTitleColor(defaultFontColor, for: .normal)
        }
    }
    
    var dateComponents = DateComponents()
    let defaultFontColor = UIColor.init(red: 233.0/255, green: 160.0/255, blue: 52.0/255, alpha: 1.0)
    
    var dateSelector: DateSelectorVC!
    var personToEdit: Person?
    
    @IBOutlet weak var monthLbl: UIButton!
    @IBOutlet weak var dayLbl: UIButton!
    @IBOutlet weak var yearLbl: UIButton!
    @IBOutlet weak var nameWarningLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func monthSelection(_ sender: Any) {
        dateSelector.dateComponentsSelectionMode = DateComponentSelectionMode.month
        present(dateSelector, animated: true, completion: nil)
    }
    
    @IBAction func daySelection(_ sender: Any) {
        dateSelector.dateComponentsSelectionMode = DateComponentSelectionMode.day
        present(dateSelector, animated: true, completion: nil)
    }
    
    @IBAction func yearSelection(_ sender: Any) {
        dateSelector.dateComponentsSelectionMode = DateComponentSelectionMode.year
        present(dateSelector, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(ad.persistentContainer.persistentStoreDescriptions.first?.url! ?? "")
        
        dateSelector = storyboard?.instantiateViewController(withIdentifier: "DateSelectorVC") as? DateSelectorVC
        dateSelector.delegate = self
        if personToEdit != nil {
            loadPersonData()
        } else {
            updateLabel(dayLbl, newValue: nil, mode: .day)
            updateLabel(monthLbl, newValue: nil, mode: .month)
            updateLabel(yearLbl, newValue: nil, mode: .year)
        }

        self.hideKeyboardWhenTappedAround()
        self.nameField.delegate = self
    }
    
    func loadPersonData() {
        if let person = personToEdit {
            let df = DateFormatter()
            let birthdate = person.birthdate! as Date
            df.dateFormat = "yyyy"
            dateSelector?.year = Int(df.string(from: birthdate))!
            print("Loaded person's birth year: \(String(describing: dateSelector?.year))")
            df.dateFormat = "M"
            dateSelector?.month = Int(df.string(from: birthdate))!
            print("Loaded person's birth month: \(String(describing: df.string(from: birthdate)))")
            df.dateFormat = "d"
            dateSelector?.day = Int(df.string(from: birthdate))!
            print("Loaded person's birth day: \(String(describing: dateSelector?.day))")
            nameField.text = person.name
            
            if person.name == "" || person.name == nil {
                nameLbl.text = "Tap to select a birthday:"
            } else if (person.name?.count)! > 16 {
                nameLbl.text = "Birthday:"
            } else {
                nameLbl.text = "\(person.name ?? "")'s birthday:"
            }
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func checkZodiacPressed(_ sender: Any) {
        
        
        guard monthLbl.title(for: UIControlState.normal) != "Month" else {
            monthLbl.setTitleColor(UIColor.red, for: UIControlState.normal)
            return
        }
        guard dayLbl.title(for: UIControlState.normal) != "Day," else {
            dayLbl.setTitleColor(UIColor.red, for: UIControlState.normal)
            return
        }
        guard yearLbl.title(for: UIControlState.normal) != "Year" else {
            yearLbl.setTitleColor(UIColor.red, for: UIControlState.normal)
            return
        }
        doSegue()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToZodiacSignView" {
            if let destination = segue.destination as? ZodiacSignView {
                if let date = sender as? Date {
                    destination.birthdate = date
                }
            }
        }
        
    }
    
    func doSegue() {
        if nameField.text == "" {
            print("Plesae enter a name")
            nameWarningLbl.isHidden = false
            nameField.becomeFirstResponder()
        } else {
            var person: Person!
            if personToEdit != nil {
                person = personToEdit
            } else {
                person = Person(context: context)
            }
            dateComponents.calendar = Calendar.current
            if let birthdate = dateComponents.date {
                person.birthdate = birthdate
                person.name = nameField.text
                person.zodiac = Int16(birthdate.getZodiacRank())
            }
            ad.saveContext()
            
            performSegue(withIdentifier: "ToZodiacSignView", sender: dateComponents.date)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    func animateTextField(textField: UITextField, up: Bool)
    {
        let movementDistance:CGFloat = -130
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    @IBAction func nameFieldEditingChanged(_ sender: Any) {
        if nameField.text != "" {
            nameWarningLbl.isHidden = true
            if (nameField.text?.count)! > 16 {
                nameLbl.text = "Birthday:"
            } else {
                nameLbl.text = "\(nameField.text ?? "")'s birthday:"
            }
        } else {
            nameWarningLbl.isHidden = false
            nameLbl.text = ""
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.animateTextField(textField: textField, up:true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        self.animateTextField(textField: textField, up:false)
    }
    
    
}


extension BirthdaySelectionView: PickerViewDelegate {
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: PickerView, didTapRow row: Int) {
        switch dateSelector.dateComponentsSelectionMode! {
        case .month:
            self.month = row + 1
        case .day:
            self.day = row + 1
        case .year:
            self.year = row + 1
        }
        dateSelector.dismiss(animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        label.textColor = UIColor(red: 233.0/255, green: 160.0/255, blue: 52.0/255, alpha: 1.0)
        
        if highlighted {
            label.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        } else {
            label.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        }
    }
}
