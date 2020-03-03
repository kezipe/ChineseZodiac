//
//  MatchResultCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit



final class MatchResultCell: UITableViewCell {
  
  lazy var person1Zodiac: UIImageView = {
    let imageView = UIImageView.zodiacImageView
    return imageView
  }()
  
  lazy var person1Name: UILabel = {
    let label = UILabel.personLabel
    return label
  }()
  
  lazy var compatibilityLbl: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 2
    return label
  }()
  
  lazy var person2Zodiac: UIImageView = {
    let imageView = UIImageView.zodiacImageView
    return imageView
  }()
  
  lazy var person2Name: UILabel = {
    let label = UILabel.personLabel
    label.textAlignment = .right
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  func setupUI() {
    let IMAGE_SIZE: CGFloat = 50
    let MATCH_LABEL_WIDTH: CGFloat = 200
    let PADDING_HORIZONTAL: CGFloat = 30
    let PADDING_VERTICAL: CGFloat = 10
    let WIDTH_NAME_LABEL: CGFloat = MATCH_LABEL_WIDTH
    
    addSubview(person1Zodiac)
    person1Zodiac.leftAnchor.constraint(equalTo: leftAnchor, constant: PADDING_HORIZONTAL).isActive = true
    person1Zodiac.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -PADDING_VERTICAL).isActive = true
    person1Zodiac.widthAnchor.constraint(equalToConstant: IMAGE_SIZE).isActive = true
    person1Zodiac.heightAnchor.constraint(equalToConstant: IMAGE_SIZE).isActive = true
    
    addSubview(person1Name)
    person1Name.leftAnchor.constraint(equalTo: leftAnchor, constant: PADDING_HORIZONTAL).isActive = true
    person1Name.topAnchor.constraint(equalTo: topAnchor,
                                     constant: PADDING_VERTICAL).isActive = true
    person1Name.widthAnchor.constraint(equalToConstant: WIDTH_NAME_LABEL).isActive = true
    
    addSubview(compatibilityLbl)
    compatibilityLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    compatibilityLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    compatibilityLbl.widthAnchor.constraint(equalToConstant: MATCH_LABEL_WIDTH).isActive = true
    
    addSubview(person2Zodiac)
    person2Zodiac.rightAnchor.constraint(equalTo: rightAnchor, constant: -PADDING_HORIZONTAL).isActive = true
    person2Zodiac.topAnchor.constraint(equalTo: topAnchor, constant: PADDING_VERTICAL).isActive = true
    person2Zodiac.widthAnchor.constraint(equalToConstant: IMAGE_SIZE).isActive = true
    person2Zodiac.heightAnchor.constraint(equalToConstant: IMAGE_SIZE).isActive = true
    
    addSubview(person2Name)
    person2Name.rightAnchor.constraint(equalTo: rightAnchor, constant: -PADDING_HORIZONTAL).isActive = true
    person2Name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -PADDING_VERTICAL).isActive = true
    person2Name.widthAnchor.constraint(equalToConstant: WIDTH_NAME_LABEL).isActive = true
  }
  
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
    configureEmptyRightCell()
    
    setFontColor(for: .alone)
    setFontSize(for: .alone)
    setCompatibilityLabelText("Alone")
  }
  
  fileprivate func configureNormalCell(match: Match) {
    let person1 = match.firstPerson
    let person2 = match.secondPerson
    
    configureLeftCell(person: person1)
    configureRightCell(person: person2)
    configureCompatibility(match)
  }
  
  fileprivate func configureEmptyRightCell() {
    person2Name.text = ""
    person2Zodiac.image = nil
  }
  
  fileprivate func configureLeftCell(person: Person) {
    person1Name.text = person.name ?? ""
    let imageName = getImageName(person: person)
    if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
      person1Zodiac.image = image
    }
  }
  
  fileprivate func configureRightCell(person: Person) {
    person2Name.text = person.name ?? ""
    let imageName = getImageName(person: person)
    if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
      person2Zodiac.image = image
    }
  }
  
  fileprivate func getImageName(person: Person) -> String {
    return person.zodiacName + "_thumb"
  }
  
  fileprivate func configureCompatibility(_ match: Match) {
    setFontColor(for: match.compatibility)
    setFontSize(for: match.compatibility)
    setCompatibilityLabelText(match.compatibility.description)
  }
  
  fileprivate func setFontColor(for compatibility: Compatibility) {
    let color: UIColor
    switch compatibility {
    case .alone:
      color = .systemBlue
    case .poor:
      color = .systemGray
    case .average:
      color = .systemTeal
    case .goodMatchOrEnemy:
      color = .systemYellow
    case .goodFriend:
      color = .systemOrange
    case .complementary:
      color = .systemPink
    case .perfect:
      color = .systemRed
    }
    setFontColor(color)
  }
  
  fileprivate func setFontSize(for compatibility: Compatibility) {
    let size: CGFloat
    switch compatibility {
    case .alone:
      size = 11
    case .poor:
      size = 12
    case .average:
      size = 13
    case .goodMatchOrEnemy:
      size = 14
    case .goodFriend:
      size = 15
    case .complementary:
      size = 16
    case .perfect:
      size = 17
    }
    setFontSize(size)
  }
  
  fileprivate func setCompatibilityLabelText(_ text: String) {
    compatibilityLbl.text = text
  }
  
  fileprivate func setFontColor(_ color: UIColor) {
    compatibilityLbl.textColor = color
  }
  
  fileprivate func setFontSize(_ size: CGFloat) {
    compatibilityLbl.font = UIFont(name: "Baskerville-Bold", size: size)
  }
}
