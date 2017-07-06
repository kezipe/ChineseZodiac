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
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        if let person = person {
            // MARK: Navigator Bar
            navBar.topItem?.title = person.name
            
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
                adYearLbl.text = "\(birthdate.getAhYear()) AH"
            }
            // MARK: Lunar Month
            lunarMonthLbl.text = birthdate.getLunarMonth()
            // MARK: Season
            seasonLbl.text = birthdate.getSeason()
            // MARK: Solar Term
            solarTermLbl.text = birthdate.getSolarTerm()
      
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
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if person != nil {
            context.delete(person!)
            ad.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
