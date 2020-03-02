//
//  BirthdaySelectionView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class BirthdaySelectionViewController: UIViewController {

  @IBOutlet weak var zodiacImage: UIImageView!
  @IBOutlet weak var zodiacLabel: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  fileprivate var isZodiacChosen = false
  
  var personToEdit: Person?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func dateChanged(_ sender: Any) {
    isZodiacChosen = true
    updateImage()
    updateLabel()
  }
  
  fileprivate func updateImage() {
    let zodiacName = getZodiacName()
    if let image = UIImage(named: zodiacName) {
      zodiacImage.image = image
    }
  }
  
  fileprivate func updateLabel() {
    zodiacLabel.text = getZodiacName()
  }
  
  fileprivate func getZodiacName() -> String {
    let date = datePicker.date
    return date.getZodiac().name
  }

  @IBAction func saveButtonPressed(_ sender: Any) {
    saveZodiac()
  }
  
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
    let title = "Save"
    let dateSelected = datePicker.date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d, yyyy"
    let dateString = dateFormatter.string(from: dateSelected)
    let message = "Are you sure your birthday is \(dateString)"
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
      
      self?.save(name: text)
      self?.navigationController?.popToRootViewController(animated: true)
    }
  }
  
  fileprivate func save(name: String) {
    let birthday = datePicker.date
    PersonDataManager.shared.save(birthday: birthday, name: name)
  }
}




