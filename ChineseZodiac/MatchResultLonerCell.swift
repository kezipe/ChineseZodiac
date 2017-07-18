//
//  MatchResultLonerCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-18.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class MatchResultLonerCell: UITableViewCell {

    @IBOutlet weak var zodiacImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    func configureCell(person: Person) {
        zodiacImg.image = UIImage(named: "\(Helper.getZodiac(fromIndex: Int(person.zodiac)))")
        nameLbl.text = person.name
    }

}
