//
//  MatchResultCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class MatchResultCell: UITableViewCell {
  
  
  @IBOutlet weak var person1Zodiac: UIImageView!
  @IBOutlet weak var person1Name: UILabel!
  
  @IBOutlet weak var matchScoreLbl: UILabel!
  
  @IBOutlet weak var person2Zodiac: UIImageView!
  @IBOutlet weak var person2Name: UILabel!
  
  func configureCell(match: Match) {
    if match.isAlone {
      configureLonerCell(match: match)
    } else {
      configureNormalCell(match: match)
    }
  }
  
  fileprivate func configureLonerCell(match: Match) {
    let loner = match.loner!
    configureLeftCell(person: loner)
    
    person2Name.text = ""
    person2Zodiac.image = nil
    
    matchScoreLbl.text = "Alone"
    matchScoreLbl.font = UIFont.systemFont(ofSize: 9)
  }
  
  fileprivate func configureNormalCell(match: Match) {
    let person1 = match.firstPerson
    let person2 = match.secondPerson
    let compatibility = match.compatibility
    
    configureLeftCell(person: person1)
    configureRightCell(person: person2)
    
    configureCompatibility(compatibility, match)
    
    layer.cornerRadius = 8.0
    
  }
  
  fileprivate func configureLeftCell(person: Person) {
    person1Name.text = person.name ?? ""
    person1Zodiac.image = UIImage(named: person.zodiacName) ?? nil
  }
  
  fileprivate func configureRightCell(person: Person) {
    person2Name.text = person.name ?? ""
    person2Zodiac.image = UIImage(named: person.zodiacName) ?? nil
  }
  
  fileprivate func configureCompatibility(_ compatibility: Int, _ match: Match) {
    var matchScoreLblTextSize: CGFloat
    
    switch compatibility {
    case 6:
      matchScoreLblTextSize = 15.0
      setFontColor()
    case 5:
      matchScoreLblTextSize = 9.0
    case 4, 3:
      matchScoreLblTextSize = 12.0
    default:
      matchScoreLblTextSize = 13.0
    }
    
    matchScoreLbl.text = match.compatibilityName
    matchScoreLbl.font = .systemFont(ofSize: matchScoreLblTextSize)
  }
  
  fileprivate func setFontColor() {
    matchScoreLbl.textColor = Helper.colorRed
  }
  
}
