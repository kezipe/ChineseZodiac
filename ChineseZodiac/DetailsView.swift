//
//  DetailsView.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-21.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class DetailsView: UIView {
  
  @IBOutlet weak var zodiacImg: UIImageView!
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var zodiacLbl: UILabel!
  
  @IBOutlet weak var birthdayLbl: UILabel!
  @IBOutlet weak var cBirthdayLbl: UILabel!
  @IBOutlet weak var stemBranchLbl: UILabel!
  @IBOutlet weak var adYearLbl: UILabel!
  
  @IBOutlet weak var lunarMonthLbl: UILabel!
  @IBOutlet weak var fixedElementLbl: UILabel!
  @IBOutlet weak var seasonLbl: UILabel!
  @IBOutlet weak var solarTermLbl: UILabel!
  @IBOutlet weak var compatibilityLbl: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func updateInformation(forPerson person: Person) {
    
    if let name = person.name,
      let birthday = person.birthdate {
      
      let zodiacSign = birthday.getZodiac()
      
      updateNameLabel(name)
      updateZodiacImage(zodiacSign)
      updateZodiacLabel(zodiacSign)
      updateBirthdayLabel(birthday)
      updateChineseBirthdayLabel(birthday)
      updateStemBranchLabel(birthday)
      updateAhYearLabel(birthday)
      updateLunarMonthLabel(birthday)
      updateSeasonLabel(birthday)
      updateSolarTermLabel(birthday)
      updateFixedTermLabel(birthday)
      updateCompatibilityLabel(fromRank: person.zodiac)
    }
  }
  
  fileprivate func updateZodiacLabel(_ zodiacSign: String) {
    zodiacLbl.text = zodiacSign
  }
  
  fileprivate func updateZodiacImage(_ zodiacSign: String) {
    zodiacImg.image = UIImage(named: zodiacSign)
  }
  
  fileprivate func updateNameLabel(_ name: String) {
    nameLbl.text = name
  }
  
  fileprivate func updateBirthdayLabel(_ birthday: Date) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    birthdayLbl.text = dateFormatter.string(from: birthday)
  }
  
  func updateChineseBirthdayLabel(_ birthday: Date) {
    cBirthdayLbl.text = birthday.formatChineseCalendarDate()
  }
  
  func updateStemBranchLabel(_ birthday: Date) {
    stemBranchLbl.text = birthday.getStemBranch()
  }
  
  func updateAhYearLabel(_ birthday: Date) {
    if birthday.getAhYear() > 1 {
      adYearLbl.text = "\(birthday.getAhYear()) AH"
    } else {
      adYearLbl.text = "\(birthday.getAhYear()) BH"
    }
  }
  
  func updateLunarMonthLabel(_ birthday: Date) {
    lunarMonthLbl.text = birthday.getLunarMonth()
  }
  
  func updateSeasonLabel(_ birthday: Date) {
    seasonLbl.text = birthday.getSeason()
  }
  
  func updateSolarTermLabel(_ birthday: Date) {
    solarTermLbl.text = birthday.getSolarTerm()
  }
  
  func updateFixedTermLabel(_ birthday: Date) {
    fixedElementLbl.text = birthday.getFixedElement()
  }
  
  func updateCompatibilityLabel(fromRank zodiacRank: Int16) {
    var compatibility = ""
    for i in 1...12 {
      let bestZodiacForSelf = Helper.match(person1: Int(zodiacRank), person2: i)
      if bestZodiacForSelf == 6 {
        compatibility += "\(Helper.getZodiac(fromIndex: i)), "
      }
    }
    let last2Chars = compatibility.index(compatibility.endIndex, offsetBy: -2)
    compatibility.removeSubrange(last2Chars..<compatibility.endIndex)
    compatibilityLbl.text = compatibility
  }
  
  
}
