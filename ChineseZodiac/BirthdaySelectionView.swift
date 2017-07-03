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
//    var birthdate: Date!

    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        print(ad.persistentContainer.persistentStoreDescriptions.first?.url! ?? "")
//        self.birthdate = datePicker.date
        
    }
    
    @IBAction func dateSelected(_ sender: Any) {
        self.birthdate = datePicker.date
    }

    
    @IBAction func checkZodiacPressed(_ sender: Any) {
        person.name = "John"
        person.birthdate = self.birthdate! as NSDate
        ad.saveContext()
        performSegue(withIdentifier: "ToZodiacSignView", sender: datePicker.date)
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

