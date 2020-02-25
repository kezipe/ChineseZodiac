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
    let zodiacSign = person.zodiacSign
    zodiacImg.image = UIImage(named: zodiacSign.name)
    nameLbl.text = person.name
  }
  
}
