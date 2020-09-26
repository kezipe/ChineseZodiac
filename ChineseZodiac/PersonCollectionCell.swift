//
//  PersonColCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class PersonCollectionCell: UICollectionViewCell {
  @IBOutlet weak var zodiacImg: UIImageView!
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var checkMarkImg: UIImageView!  

  func configureCell(person: Person, isSelected: Bool) {
    configureNameLabel(person)
    configureImage(person)
    configureCheckMark(isSelected)
    configureHighlight(isSelected)
  }
  
  fileprivate func configureNameLabel(_ person: Person) {
    nameLbl.text = person.name
  }
  
  fileprivate func configureImage(_ person: Person) {
    let imageName = person.zodiacSign.rawValue.capitalized + "_thumb"
    if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
      zodiacImg.image = image
    }
  }
  
  fileprivate func configureHighlight(_ isSelected: Bool) {
    if isSelected {
      highlightPerson()
    } else {
      dehighlightPerson()
    }
  }
  
  func highlightPerson() {
    if #available(iOS 13, *) {
      zodiacImg.tintColor = .label
    } else {
      zodiacImg.tintColor = .black
    }
  }
  
  func dehighlightPerson() {
    if #available(iOS 13, *) {
      zodiacImg.tintColor = .secondaryLabel
    } else {
      zodiacImg.tintColor = .gray
    }
  }
  
  fileprivate func configureCheckMark(_ isSelected: Bool) {
    checkMarkImg.image = checkMarkImg.image?.withRenderingMode(.alwaysTemplate)
    checkMarkImg.isHidden = !isSelected
  }
}
