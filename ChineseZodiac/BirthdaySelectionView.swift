//
//  BirthdaySelectionView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class BirthdaySelectionView: UIViewController, UITextFieldDelegate {
    //  https://www.timeanddate.com/calendar/about-chinese.html
    
    enum DateComponentSelectionMode {
        case dayMode, monthMode, yearMode
    }
    var month: Int? = nil
    var day:Int? = nil
    var year: Int? = nil
    var dateComponents = DateComponents()
    var monthChanged = true
    var dayChanged = true
    var yearChanged = true
    let defaultFontColor = UIColor.init(red: 233.0/255, green: 160.0/255, blue: 52.0/255, alpha: 1.0)
    
    var dateSelector: DateSelectorVC?
    var personToEdit: Person?
    
    
    @IBOutlet weak var monthLbl: UIButton!
    @IBOutlet weak var dayLbl: UIButton!
    @IBOutlet weak var yearLbl: UIButton!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    @IBAction func monthSelection(_ sender: Any) {
        dateSelector?.dateComponentsSelectionMode = DateComponentSelectionMode.monthMode
        monthChanged = true
        present(dateSelector!, animated: true, completion: nil)
    }
    
    @IBAction func daySelection(_ sender: Any) {
        dateSelector?.dateComponentsSelectionMode = DateComponentSelectionMode.dayMode
        present(dateSelector!, animated: true, completion: nil)
    }
    
    @IBAction func yearSelection(_ sender: Any) {
        dateSelector?.dateComponentsSelectionMode = DateComponentSelectionMode.yearMode
        yearChanged = true
        present(dateSelector!, animated: true, completion: nil)
    }
    
    
    func refreshUI() {
        
        if let m = dateSelector?.month {
            month = m
        }
        
        if let y = dateSelector?.year {
            year = y
        }
        
        if let d = dateSelector?.day {
            if let m = month {
                let yearCheck: Int!
                if let y = year {
                    yearCheck = y
                } else {
                    yearCheck = 2000
                }
                //                print("Year which is about to be checked is \(String(describing:yearCheck!)))")
                //                print("Month which is about to be checked is \(String(describing:m)))")
                let numDaysInMonth = m.toNumDaysInMonth(year: yearCheck)
                if d > numDaysInMonth {
                    day = numDaysInMonth
                    dateSelector?.day = numDaysInMonth
                } else {
                    day = d
                }
            } else {
                day = d
            }
            dayChanged = true
        }
        
        if monthChanged {
            dateComponents.month = month == nil ? nil : month!
            monthLbl.setTitle("\(String(describing: month == nil ? "Month" : month!.toMonthName()))", for: UIControlState.normal)
            monthLbl.setTitleColor(defaultFontColor, for: UIControlState.normal)
            monthChanged = false
        }
        if dayChanged {
            dateComponents.day = day == nil ? nil : day!
            dayLbl.setTitle("\(day == nil ? "Day" : String(describing: (day!))),", for: UIControlState.normal)
            dayLbl.setTitleColor(defaultFontColor, for: UIControlState.normal)
            dayChanged = false
        }
        if yearChanged {
            dateComponents.year = year == nil ? nil : year!
            yearLbl.setTitle("\(year == nil ? "Year" : String(describing: year!))", for: UIControlState.normal)
            yearLbl.setTitleColor(defaultFontColor, for: UIControlState.normal)
            yearChanged = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshUI()
    }
    
    override func viewDidLoad() {
        //        print(ad.persistentContainer.persistentStoreDescriptions.first?.url! ?? "")
        
        dateSelector = storyboard?.instantiateViewController(withIdentifier: "DateSelectorVC") as? DateSelectorVC
        if personToEdit != nil {
            loadPersonData()
        }
        refreshUI()
        

        
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
                nameLbl.text = "Please select a birthday:"
            } else {
                nameLbl.text = "\(person.name ?? "")'s birthday:"
            }
            
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
            nameField.becomeFirstResponder()
        } else {
            var person: Person!
            if personToEdit != nil {
                person = personToEdit
            } else {
                person = Person(context: context)
            }
            dateComponents.calendar = Calendar.current
            person.birthdate = dateComponents.date as NSDate?
            person.name = nameField.text
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
            nameLbl.text = "\(nameField.text ?? "")'s birthday:"
        } else {
            nameLbl.text = "Please choose a name"
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

