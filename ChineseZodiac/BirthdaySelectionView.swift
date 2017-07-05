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
    
    var person = Person(context: context)

    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
//        print(ad.persistentContainer.persistentStoreDescriptions.first?.url! ?? "")
        self.hideKeyboardWhenTappedAround()
        self.nameField.delegate = self
    }
    
    @IBAction func dateSelected(_ sender: Any) {
    }

    
    @IBAction func checkZodiacPressed(_ sender: Any) {
        if nameField.text == "" {
            print("Plesae enter a name")
        } else {
            person.birthdate = datePicker.date as NSDate
            person.name = nameField.text
            ad.saveContext()
            performSegue(withIdentifier: "ToZodiacSignView", sender: datePicker.date)
        }
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            textField.resignFirstResponder()
            performSegue(withIdentifier: "ToZodiacSignView", sender: datePicker.date)
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.animateTextField(textField: textField, up:true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        self.animateTextField(textField: textField, up:false)
    }
    
    
}

