//
//  ZodiacSignView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class ZodiacSignView: UIViewController {
    
    var birthdate: Date?

    
    @IBOutlet weak var cDateLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var zodiacSignLbl: UILabel!
    @IBAction func doneButtonPressed(_ sender: UIButton){
        let person = Person(context: context)
        
        if birthdate == nil {
        
        } else {
            person.name = "Kevin"
            person.birthdate = self.birthdate! as NSDate
            ad.saveContext()
        }
        

    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ToTableView" {
//            if let destination = segue.destination as? TableView {
//                if let date = sender as? Date {
//                    destination.birthdate = date
//                }
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLbl.isHidden = false

        if let birthdayString = birthdate?.format(calendarId: Calendar.current.identifier) {
            dateLbl.text = birthdayString
        }
        
        if let cBirthdayString = birthdate?.getZodiacChar() {
            cDateLbl.text = cBirthdayString
        }
        
        if let zodiacSign = birthdate?.getZodiac() {
            zodiacSignLbl.text = zodiacSign
        }
    }
    
    
}

