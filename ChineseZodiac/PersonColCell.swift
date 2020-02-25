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
  @IBOutlet weak var checkMarkImg: UIImageView!  
  
  func configureCell(person: Person, isSelected: Bool) {
    nameLbl.text = person.name
    let imageName = person.zodiacSign.name + "_thumb"
    zodiacImg.image = UIImage(named: imageName)
    
    checkMarkImg.isHidden = !isSelected
  }
  
}
