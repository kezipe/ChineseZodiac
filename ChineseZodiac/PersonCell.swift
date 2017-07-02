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
    
    @IBOutlet weak var zodiacImg: UIImageView!
    
    func configureCell(person: Person) -> UITableViewCell {
        print(person.name!)
        if let name = person.name {
            personLbl.text = name
        }
        let birthdate = person.birthdate! as Date
        zodiacLbl.text = birthdate.getZodiac()
        return self
    }
}
