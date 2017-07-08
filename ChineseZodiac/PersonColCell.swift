//
//  PersonColCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class PersonColCell: UICollectionViewCell {
    @IBOutlet weak var zodiacImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    func configureCell(person: Person) {
        nameLbl.text = person.name
        let birthday = person.birthdate! as Date
        zodiacImg.image = UIImage(named: "\(birthday.getZodiac())_thumb")
    }
}
