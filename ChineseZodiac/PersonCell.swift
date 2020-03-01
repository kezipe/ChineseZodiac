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
  
  func configureCell(person: Person) {
    updatePersonLabel(person)
    updateZodiacLabel(person)
    updateZodiacImage(person)
    accessoryType = .disclosureIndicator
  }
  
  fileprivate func updatePersonLabel(_ person: Person) {
    personLbl.text = person.name
  }
  
  fileprivate func updateZodiacLabel(_ person: Person) {
    zodiacLbl.text = person.zodiacName
  }
  
  fileprivate func updateZodiacImage(_ person: Person) {
    zodiacImg.image = UIImage(named: "\(person.zodiacName)_thumb")
  }
  

}
