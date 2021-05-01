//
//  BirthdaySelectionView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit
import Zodiacs

final class BirthdaySelectionViewController: UIViewController {

  lazy var zodiacImage: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
    return iv
  }()

  lazy var zodiacLabel: UILabel = {
    let label = UILabel()
    if #available(iOS 13, *) {
      label.textColor = .label
    } else {
      label.textColor = .black
    }
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var selectBirthdayLabel: UILabel = {
    let label = UILabel()
    if #available(iOS 13, *) {
      label.textColor = .label
    } else {
      label.textColor = .black
    }
    label.text = "Select a birthday"
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    if #available(iOS 13.4, *) {
      datePicker.preferredDatePickerStyle = .wheels
    }
    datePicker.datePickerMode = .date
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.heightAnchor.constraint(
        greaterThanOrEqualToConstant: 120
    ).isActive = true
    datePicker.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    datePicker.addTarget(
        self,
        action: #selector(dateChanged),
        for: .valueChanged
    )
    return datePicker
  }()

  lazy var saveToListButton: UIButton = {
    let button = UIButton()
    button.setTitle("Save to List", for: .normal)
    button.backgroundColor = .accentColor
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(saveZodiac), for: .touchUpInside)
    NSLayoutConstraint.activate(
      [
        button.heightAnchor.constraint(equalToConstant: 44)
      ]
    )
    return button
  }()

  fileprivate var isZodiacChosen = false
  
  var personToEdit: Person?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewBackgroundColor()
    setupUI()
    updateLabel()
    updateImage()
  }

  private func setupUI() {
    view.addSubview(zodiacImage)
    view.addSubview(zodiacLabel)
    view.addSubview(datePicker)
    view.addSubview(selectBirthdayLabel)
    view.addSubview(saveToListButton)
    let multiplier: CGFloat = 1.0
    NSLayoutConstraint.activate(
      [
        selectBirthdayLabel.centerXAnchor.constraint(equalTo: zodiacImage.centerXAnchor)
      ]
    )
    if #available(iOS 11, *) {
      NSLayoutConstraint.activate(
        [
          zodiacImage.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
            multiplier: multiplier * 4
          ),
          zodiacImage.leadingAnchor.constraint(
              equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
              multiplier: multiplier * 4
          ),
          view.safeAreaLayoutGuide.trailingAnchor.constraint(
              equalToSystemSpacingAfter: zodiacImage.trailingAnchor,
              multiplier: multiplier * 4
          ),
          zodiacLabel.topAnchor.constraint(
            equalToSystemSpacingBelow: zodiacImage.bottomAnchor,
            multiplier: multiplier * 2
          ),
          zodiacLabel.centerXAnchor.constraint(
              equalTo: zodiacImage.centerXAnchor
          ),
          selectBirthdayLabel.topAnchor.constraint(
              equalToSystemSpacingBelow: zodiacLabel.bottomAnchor,
              multiplier: multiplier * 2
          ),
          datePicker.topAnchor.constraint(
            equalToSystemSpacingBelow: selectBirthdayLabel.bottomAnchor,
            multiplier: multiplier
          ),
          datePicker.centerXAnchor.constraint(
              equalTo: zodiacLabel.centerXAnchor
          ),
          saveToListButton.topAnchor.constraint(
            equalToSystemSpacingBelow: datePicker.bottomAnchor,
            multiplier: multiplier
          ),
          saveToListButton.leadingAnchor.constraint(
              equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
              multiplier: multiplier
          ),
          view.safeAreaLayoutGuide.trailingAnchor.constraint(
              equalToSystemSpacingAfter: saveToListButton.trailingAnchor,
              multiplier: multiplier
          ),
          view.safeAreaLayoutGuide.bottomAnchor.constraint(
              equalToSystemSpacingBelow: saveToListButton.bottomAnchor,
              multiplier: 1
          )
        ]
      )
    }
  }

  private func configureViewBackgroundColor() {
    if #available(iOS 13, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
  }
  
  @objc
  func dateChanged(_ sender: Any) {
    isZodiacChosen = true
    updateImage()
    updateLabel()
  }
  
  fileprivate func updateImage() {
    let zodiacName = getZodiacName()
    if let image = UIImage(named: zodiacName)?.withRenderingMode(.alwaysTemplate) {
      zodiacImage.image = image
    }
  }
  
  fileprivate func updateLabel() {
    zodiacLabel.text = getZodiacName()
  }
  
  fileprivate func getZodiacName() -> String {
    ChineseZodiac(date: datePicker.date)?.description ?? ""
  }

  @IBAction func saveButtonPressed(_ sender: Any) {
    saveZodiac()
  }
  
  @objc
  fileprivate func saveZodiac() {
    let alertController: UIAlertController
    if isZodiacChosen {
      alertController = getSaveUI()
    } else {
      alertController = getMessageUI()
    }
    present(alertController, animated: true)
  }
  
  fileprivate func getSaveUI() -> UIAlertController {
    let title = "Save"
    let message = "Enter a name:"
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let saveAction = createSaveButton(alertController: alertController)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(cancelAction)
    alertController.addAction(saveAction)
    alertController.addTextField(configurationHandler: configureTextField)
    return alertController
  }
  
  fileprivate func getMessageUI() -> UIAlertController {
    let title = "Save to List"
    let dateSelected = datePicker.date
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "MMMM d, yyyy"
    let dateString = dateFormatter.string(from: dateSelected)
    let message = "Save the birthday as \(dateString)?"
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let yesAction = UIAlertAction(title: "Yes", style: .default, handler: handleDefaultBirthdaySelected)
    let noAction = UIAlertAction(title: "No", style: .cancel)
    alertController.addAction(noAction)
    alertController.addAction(yesAction)
    return alertController
  }
  
  fileprivate func handleDefaultBirthdaySelected(_ action: UIAlertAction) {
    isZodiacChosen = true
    saveZodiac()
  }
  
  fileprivate func configureTextField(_ textField: UITextField) {
    textField.placeholder = "Serena"
    textField.autocapitalizationType = .words
    textField.autocorrectionType = .no
  }
  
  fileprivate func createSaveButton(alertController: UIAlertController) -> UIAlertAction {
    return UIAlertAction(title: "OK", style: .default) { [weak self] _ in
      guard let text = alertController.textFields?.first?.text else {
        return
      }
      
      if text.isEmpty {
        return
      }
      
      self?.save(name: text)
      self?.navigationController?.popToRootViewController(animated: true)
    }
  }
  
  fileprivate func save(name: String) {
    let birthday = datePicker.date
    PersonDataManager.shared.create(name: name, birthday: birthday)
  }
}




