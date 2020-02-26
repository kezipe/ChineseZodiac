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
    
    if let name = person.name, let birthday = person.birthdate {
      let zodiacSign = birthday.getZodiac()
      
      updateNameLabel(name)
      updateZodiacImage(zodiacSign.name)
      updateZodiacLabel(zodiacSign.name)
      updateBirthdayLabel(birthday)
      updateChineseBirthdayLabel(birthday)
      updateStemBranchLabel(birthday)
      updateAhYearLabel(birthday)
      updateLunarMonthLabel(birthday)
      updateSeasonLabel(birthday)
      updateSolarTermLabel(birthday)
      updateFixedTermLabel(birthday)
      updateCompatibilityLabel(from: person.zodiacSign)
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
    if birthday.getYellowEmperorYear() > 1 {
      adYearLbl.text = "\(birthday.getYellowEmperorYear()) AH"
    } else {
      adYearLbl.text = "\(birthday.getYellowEmperorYear()) BH"
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
  
  func updateCompatibilityLabel(from zodiac: Zodiac) {
    let bestMatches = zodiac.findBestMatchedZodiacs()
    let bestMatchNames = bestMatches.map { $0.name }
    compatibilityLbl.text = bestMatchNames.joined(separator: ", ")
  }
  
  
}
