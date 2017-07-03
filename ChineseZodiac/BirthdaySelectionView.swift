//
//  BirthdaySelectionView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class BirthdaySelectionView: UIViewController {
    //  https://www.timeanddate.com/calendar/about-chinese.html
    
    var person = Person(context: context)

    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        print(ad.persistentContainer.persistentStoreDescriptions.first?.url! ?? "")
        
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
    
}

