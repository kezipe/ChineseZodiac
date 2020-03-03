//
//  DetailsVCTableViewDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-03-02.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

enum DetailsVCTableViewRows: String, CaseIterable {
  case chineseBirthday = "Chinese Birthday"
  case chineseYear = "Chinese Year"
  case birthday = "Gregorian Birthday"
  case zodiacSign = "Zodiac Sign"
  case solarTerm = "Solar Term"
  case stemBranch = "Stem-branch"
  case season = "Season"
  case lunarMonth = "Lunar Month"
  case fixedElement = "Fixed Element"
}

class DetailsVCTableViewDataSource: NSObject, UITableViewDataSource {
  
  var person: Person?
  
  fileprivate let CELL_IDENTIFIER = "DetailsVCTableViewCell"
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
    
    configureText(for: cell, at: indexPath.row)
    configureDetailText(for: cell, at: indexPath.row)
    return cell
  }
  
  fileprivate func configureText(for cell: UITableViewCell, at row: Int) {
    let section = getSection(at: row)
    let cellTextLabelText = section.rawValue
    cell.textLabel?.text = cellTextLabelText
  }
  
  fileprivate func configureDetailText(for cell: UITableViewCell, at row: Int) {
    let section = getSection(at: row)
    guard let birthday = person?.birthdate else {
      return
    }
    
    guard let zodiacName = person?.zodiacName else {
      return
    }
    
    switch section {
    case .chineseBirthday:
      cell.detailTextLabel?.text = updateChineseBirthday(birthday)
    case .chineseYear:
      cell.detailTextLabel?.text = updateAhYear(birthday)
    case .birthday:
      cell.detailTextLabel?.text = updateBirthday(birthday)
    case .zodiacSign:
      cell.detailTextLabel?.text = updateZodiac(zodiacName)
    case .solarTerm:
      cell.detailTextLabel?.text = updateSolarTerm(birthday)
    case .stemBranch:
      cell.detailTextLabel?.text = updateStemBranch(birthday)
    case .season:
      cell.detailTextLabel?.text = updateSeason(birthday)
    case .lunarMonth:
      cell.detailTextLabel?.text = updateLunarMonth(birthday)
    case .fixedElement:
      cell.detailTextLabel?.text = updateFixedTerm(birthday)
    }
  }
  
  fileprivate func getSection(at row: Int) -> DetailsVCTableViewRows {
    let allCases = DetailsVCTableViewRows.allCases
    let section = allCases[row]
    return section
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DetailsVCTableViewRows.allCases.count
  }
  
  
  
  fileprivate func updateZodiac(_ zodiacSign: String) -> String {
    return zodiacSign
  }
  
  fileprivate func updateBirthday(_ birthday: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: birthday)
  }
  
  func updateChineseBirthday(_ birthday: Date) -> String {
    return birthday.formatChineseCalendarDate()
  }
  
  func updateStemBranch(_ birthday: Date) -> String {
    return birthday.getStemBranch()
  }
  
  func updateAhYear(_ birthday: Date) -> String {
    if birthday.getYellowEmperorYear() > 1 {
      return "\(birthday.getYellowEmperorYear()) AH"
    } else {
      return "\(birthday.getYellowEmperorYear()) BH"
    }
  }
  
  func updateLunarMonth(_ birthday: Date) -> String {
    return birthday.getLunarMonth()
  }
  
  func updateSeason(_ birthday: Date) -> String {
    return birthday.getSeason()
  }
  
  func updateSolarTerm(_ birthday: Date) -> String {
    return birthday.getSolarTerm()
  }
  
  func updateFixedTerm(_ birthday: Date) -> String {
    return birthday.getFixedElement()
  }
}
