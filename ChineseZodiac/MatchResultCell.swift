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
  
  func configureLonerCell(match: Match) {
    let loner = match.loner!
    person1Name.text = loner.name!
    person1Zodiac.image = UIImage(named: loner.zodiacName)
    
    person2Name.text = ""
    person2Zodiac.image = nil
    
    matchScoreLbl.text = "Alone"
    matchScoreLbl.font = UIFont.systemFont(ofSize: 9)
  }
  
  func configureNormalCell(match: Match) {
    let person1 = match.firstPerson
    let person2 = match.secondPerson
    let compatibility = match.compatibility
    person1Name.text = person1.name!
    person1Zodiac.image = UIImage(named: person1.zodiacName)
    person2Name.text = person2.name!
    person2Zodiac.image = UIImage(named: person2.zodiacName)
    
    var matchScoreLblTextSize: CGFloat
    
    switch compatibility {
    case 6:
      matchScoreLblTextSize = 15.0
    case 5:
      matchScoreLblTextSize = 9.0
    case 4, 3:
      matchScoreLblTextSize = 12.0
    default:
      matchScoreLblTextSize = 13.0
    }
    
    let attrCompatibility = NSAttributedString(string: match.compatibilityName,
                                               attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: matchScoreLblTextSize)])
    
    matchScoreLbl.attributedText = attrCompatibility
    
    layer.cornerRadius = 8.0
    
    if compatibility == 6 {
      matchScoreLbl.textColor = Helper.colorRed
    }
  }
  
}
