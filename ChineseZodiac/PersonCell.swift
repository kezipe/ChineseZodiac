//
//  PersonCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-06-03.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class PersonCell: UITableViewCell {
  // MARK: Private Types
  // MARK: API Variables
  // MARK: Private Variables
  private lazy var personLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var zodiacLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var zodiacImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    NSLayoutConstraint.activate(
      [
        imageView.widthAnchor.constraint(equalToConstant: 32),
        imageView.heightAnchor.constraint(equalToConstant: 32),
      ]
    )
    return imageView
  }()

  // MARK: API Functions
  func configureCell(person: Person) {
    updatePersonLabel(person)
    updateZodiacLabel(person)
    updateZodiacImage(person)
  }

  // MARK: Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  // MARK: Private Functions
  fileprivate func setupUI() {
    addSubview(zodiacImageView)
    addSubview(personLabel)
    addSubview(zodiacLabel)
    let multiplier: CGFloat = 1.0
    NSLayoutConstraint.activate(
      [
        zodiacImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        personLabel.centerYAnchor.constraint(
          equalTo: zodiacImageView.centerYAnchor
        ),
        zodiacLabel.centerYAnchor.constraint(
          equalTo: zodiacImageView.centerYAnchor
        ),
      ]
    )
    if #available(iOS 11, *) {
      NSLayoutConstraint.activate(
        [
          zodiacImageView.leadingAnchor.constraint(
            equalToSystemSpacingAfter: leadingAnchor,
            multiplier: multiplier
          ),
          personLabel.leadingAnchor.constraint(
            equalToSystemSpacingAfter: zodiacImageView.trailingAnchor,
            multiplier: multiplier
          ),
          contentView.trailingAnchor.constraint(
            equalToSystemSpacingAfter: zodiacLabel.trailingAnchor,
            multiplier: multiplier
          )
        ]
      )
    } else {
      NSLayoutConstraint.activate(
        [
          zodiacImageView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 8 * multiplier
          ),
          personLabel.leadingAnchor.constraint(
            equalTo: zodiacImageView.trailingAnchor,
            constant: 8 * multiplier
          ),
          contentView.trailingAnchor.constraint(
            equalTo: zodiacLabel.trailingAnchor,
            constant: 8 * multiplier
          ),
        ]
      )
    }
    accessoryType = .disclosureIndicator
  }

  fileprivate func updatePersonLabel(_ person: Person) {
    personLabel.text = person.name
  }

  fileprivate func updateZodiacLabel(_ person: Person) {
    zodiacLabel.text = person.zodiacName
  }

  fileprivate func updateZodiacImage(_ person: Person) {
    if let image = UIImage(named: "\(person.zodiacName!)_thumb") {
      let tintableImage = image.withRenderingMode(.alwaysTemplate)
      if #available(iOS 13, *) {
        zodiacImageView.tintColor = .label
      } else {
        zodiacImageView.tintColor = .black
      }
      zodiacImageView.image = tintableImage
    }
  }
}
