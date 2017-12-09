//
//  DetailsVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-04.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var zodiacImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var zodiacLbl: UILabel!
    
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var cBirthdayLbl: UILabel!
    @IBOutlet weak var stemBranchLbl: UILabel!
    @IBOutlet weak var adYearLbl: UILabel!

    @IBOutlet weak var lunarMonthLbl: UILabel!
    @IBOutlet weak var fixedElementLbl: UILabel!
    @IBOutlet weak var seasonLbl: UILabel!
    @IBOutlet weak var solarTermLbl: UILabel!
    @IBOutlet weak var compatibilityLbl: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        if let person = person {
            
            let birthdate = person.birthdate! as Date
            
            // MARK: Image, name and zodiac
            nameLbl.text = person.name
            zodiacLbl.text = birthdate.getZodiac()
            zodiacImg.image = UIImage(named: birthdate.getZodiac())
            
            // MARK: Birthday
            birthdayLbl.text =  dateFormatter.string(from: birthdate)
            
            // MARK: Chinese Birthday
            cBirthdayLbl.text = birthdate.formatChineseCalendarDate()
            
            // MARK: Stem-Branch
            stemBranchLbl.text = birthdate.getStemBranch()

            // MARK: AD Year
            if birthdate.getAhYear() > 1 {
                adYearLbl.text = "\(birthdate.getAhYear()) AH"
            } else {
                adYearLbl.text = "\(birthdate.getAhYear()) BH"
            }
            // MARK: Lunar Month
            lunarMonthLbl.text = birthdate.getLunarMonth()
            // MARK: Season
            seasonLbl.text = birthdate.getSeason()
            // MARK: Solar Term
            solarTermLbl.text = birthdate.getSolarTerm()
            fixedElementLbl.text = birthdate.getFixedElement()
            var compatibility = ""
            let zodiacRank = Int(person.zodiac)
            for i in 1...12 {
                let bestZodiacForSelf = Helper.match(person1: zodiacRank, person2: i)
                if bestZodiacForSelf == 6 {
                    compatibility += "\(Helper.getZodiac(fromIndex: i)), "
                }
            }
            let last2Chars = compatibility.index(compatibility.endIndex, offsetBy: -2)
            compatibility.removeSubrange(last2Chars..<compatibility.endIndex)
            compatibilityLbl.text = compatibility
        }
    }


    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if(self.isEditing) {
            self.editButtonItem.title = "Done"
            deleteButton.isHidden = false
        } else {
            self.editButtonItem.title = "Edit"
            deleteButton.isHidden = true
        }
    }
    
    
    @IBAction func EditButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "EditPerson", sender: self.person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPerson" {
            if let destination = segue.destination as? BirthdaySelectionView {
                if let person = sender as? Person {
                    destination.personToEdit = person
                }
            }
        }
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if person != nil {
            context.delete(person!)
            ad.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }


}
