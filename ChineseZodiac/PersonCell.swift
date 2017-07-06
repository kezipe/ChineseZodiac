//
//  PersonCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-06-03.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    
    @IBOutlet weak var personLbl: UILabel!
    
    @IBOutlet weak var zodiacLbl: UILabel!
    
    @IBOutlet weak var birthdateLbl: UILabel!
    
    @IBOutlet weak var zodiacImg: UIImageView!
    
    func configureCell(person: Person) {
        personLbl.text = person.name
        let zodiac = person.birthdate! as Date
        zodiacLbl.text = zodiac.getZodiac()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let birthdateString = dateFormatter.string(from: zodiac)
        birthdateLbl.text = birthdateString
        zodiacImg.image = UIImage(named: "\(zodiac.getZodiac())_thumb")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 4
    }
}
