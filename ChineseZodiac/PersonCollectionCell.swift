//
//  PersonColCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class PersonCollectionCell: UICollectionViewCell {
  private lazy var zodiacImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var checkMark: UIImageView = {
    let imageView = UIImageView()
    if #available(iOS 13, *) {
      imageView.image = UIImage(systemName: "checkmark.circle.fill")
    } else {
      imageView.image = UIImage(named: "checkMark")
    }
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI(frame: CGRect) {
    addSubview(zodiacImage)
    addSubview(nameLabel)
    addSubview(checkMark)
    let multiplier: CGFloat = 1.0
    NSLayoutConstraint.activate(
      [
        zodiacImage.topAnchor.constraint(equalTo: topAnchor),
        zodiacImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        zodiacImage.widthAnchor.constraint(equalToConstant: frame.width),
        zodiacImage.heightAnchor.constraint(equalToConstant: frame.width),
        nameLabel.topAnchor.constraint(equalTo: zodiacImage.bottomAnchor, constant: 8 * multiplier),
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        checkMark.centerYAnchor.constraint(equalTo: zodiacImage.topAnchor),
        checkMark.centerXAnchor.constraint(equalTo: zodiacImage.trailingAnchor),
        checkMark.widthAnchor.constraint(equalToConstant: 18),
        checkMark.heightAnchor.constraint(equalToConstant: 18)
      ]
    )
  }

  func configureCell(person: Person, isSelected: Bool) {
    configureNameLabel(person)
    configureImage(person)
    configureCheckMark(isSelected)
    configureHighlight(isSelected)
  }
  
  fileprivate func configureNameLabel(_ person: Person) {
    nameLabel.text = person.name
  }
  
  fileprivate func configureImage(_ person: Person) {
    let imageName = person.zodiacSign.rawValue.capitalized + "_thumb"
    if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
      zodiacImage.image = image
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
      zodiacImage.tintColor = .label
    } else {
      zodiacImage.tintColor = .black
    }
  }
  
  func dehighlightPerson() {
    if #available(iOS 13, *) {
      zodiacImage.tintColor = .secondaryLabel
    } else {
      zodiacImage.tintColor = .gray
    }
  }
  
  fileprivate func configureCheckMark(_ isSelected: Bool) {
    checkMark.image = checkMark.image?.withRenderingMode(.alwaysTemplate)
    checkMark.isHidden = !isSelected
  }
}
