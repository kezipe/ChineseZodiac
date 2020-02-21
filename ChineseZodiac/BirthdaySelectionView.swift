//
//  BirthdaySelectionView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

enum DateComponentSelectionMode: Int {
  case month, day, year
  
  func convertToString() -> String {
    switch self {
    case .day: return "Day"
    case .month: return "Month"
    case .year: return "Year"
    }
  }
}

class BirthdaySelectionView: UIViewController, UITextFieldDelegate {
  
  private let DATE_SELECTOR_IDENTIFIER = "DateSelectorVC"
  private let defaultFontColor = UIColor.init(red: 233.0/255, green: 160.0/255, blue: 52.0/255, alpha: 1.0)
  
  var dateComponents = DateComponents()
  var dateSelector: DateSelectorVC!
  var personToEdit: Person?
  
  @IBOutlet weak var monthLbl: UIButton!
  @IBOutlet weak var dayLbl: UIButton!
  @IBOutlet weak var yearLbl: UIButton!
  @IBOutlet weak var nameWarningLbl: UILabel!
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var nameField: UITextField!
  
  @IBAction func dateComponentSelected(_ sender: UIButton) {
    dateSelector.dateComponentsSelectionMode = DateComponentSelectionMode(rawValue: sender.tag)
    present(dateSelector, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dateSelector = storyboard?.instantiateViewController(withIdentifier: DATE_SELECTOR_IDENTIFIER) as? DateSelectorVC
    dateSelector.dateComponents = dateComponents
    dateSelector.delegate = self
    loadData()
    
    self.hideKeyboardWhenTappedAround()
    self.nameField.delegate = self
    setupKeyboardListeners()
  }
  
  func setupKeyboardListeners() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: #selector(adjustForKeyboard),
                                   name: UIResponder.keyboardWillHideNotification,
                                   object: nil)
    notificationCenter.addObserver(self,
                                   selector: #selector(adjustForKeyboard),
                                   name: UIResponder.keyboardWillChangeFrameNotification,
                                   object: nil)

  }
  
  @objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    let keyboardIsGoingUp: Bool
    if notification.name == UIResponder.keyboardWillHideNotification {
      keyboardIsGoingUp = false
    } else {
      keyboardIsGoingUp = true
    }
    
    let movementDistance: CGFloat
    
    if #available(iOS 11, *) {
      movementDistance = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
    } else {
      movementDistance = keyboardViewEndFrame.height
    }
    
    if keyboardIsGoingUp
    {
      self.view.transform = CGAffineTransform(translationX: 0, y: -movementDistance)
    } 
    else
    {
      self.view.transform = .identity
    }
  }

  
  func loadData() {
    if let person = personToEdit {
      let df = DateFormatter()
      let birthdate = person.birthdate! as Date
      df.dateFormat = "yyyy"
      dateComponents.year = Int(df.string(from: birthdate))!
      df.dateFormat = "M"
      dateComponents.month = Int(df.string(from: birthdate))!
      df.dateFormat = "d"
      dateComponents.day = Int(df.string(from: birthdate))!
      nameField.text = person.name
      
      if person.name == "" || person.name == nil {
        nameLbl.text = "Tap to select a birthday:"
      } else if (person.name?.count)! > 16 {
        nameLbl.text = "Birthday:"
      } else {
        nameLbl.text = "\(person.name ?? "")'s birthday:"
      }
      dateSelector.dateComponents = dateComponents
    }
    
    updateLabel(dayLbl, newValue: dateComponents.day, mode: .day)
    updateLabel(monthLbl, newValue: dateComponents.month, mode: .month)
    updateLabel(yearLbl, newValue: dateComponents.year, mode: .year)
  }
  
  func updateLabel(_ label: UIButton, newValue: Int?, mode: DateComponentSelectionMode) {
    if let newValue = newValue {
      switch mode {
      case .month:
        label.setTitle(newValue.toMonthName(), for: .normal)
      case .day:
        label.setTitle("\(newValue),", for: .normal)
      case .year:
        label.setTitle("\(newValue)", for: .normal)
      }
    } else {
      label.setTitle(mode.convertToString(), for: .normal)
      label.setTitleColor(defaultFontColor, for: .normal)
    }
  }
  
  
  @IBAction func backButtonPressed(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  
  @IBAction func checkZodiacPressed(_ sender: Any) {
    guard monthLbl.title(for: UIControl.State.normal) != "Month" else {
      monthLbl.setTitleColor(UIColor.red, for: UIControl.State.normal)
      return
    }
    guard dayLbl.title(for: UIControl.State.normal) != "Day," else {
      dayLbl.setTitleColor(UIColor.red, for: UIControl.State.normal)
      return
    }
    guard yearLbl.title(for: UIControl.State.normal) != "Year" else {
      yearLbl.setTitleColor(UIColor.red, for: UIControl.State.normal)
      return
    }
    doSegue()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ToZodiacSignView" {
      if let destination = segue.destination as? ZodiacSignView {
        if let date = sender as? Date {
          destination.birthdate = date
        }
      }
    }
    nameField.resignFirstResponder()
    
  }
  
  func doSegue() {
    if nameField.text == "" {
      nameWarningLbl.isHidden = false
      nameField.becomeFirstResponder()
    } else {
      var person: Person!
      if personToEdit != nil {
        person = personToEdit
      } else {
        person = Person(context: context)
      }
      dateComponents.calendar = Calendar.current
      if let birthdate = dateComponents.date {
        person.birthdate = birthdate
        person.name = nameField.text
        person.zodiac = Int16(birthdate.getZodiacRank())
      }
      ad.saveContext()
      
      performSegue(withIdentifier: "ToZodiacSignView", sender: dateComponents.date)
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == nameField {
      textField.resignFirstResponder()
      return false
    }
    return true
  }
  
  @IBAction func nameFieldEditingChanged(_ sender: Any) {
    if nameField.text != "" {
      nameWarningLbl.isHidden = true
      if (nameField.text?.count)! > 16 {
        nameLbl.text = "Birthday:"
      } else {
        nameLbl.text = "\(nameField.text ?? "")'s birthday:"
      }
    } else {
      nameWarningLbl.isHidden = false
      nameLbl.text = ""
    }
  }
  
}


extension BirthdaySelectionView: PickerViewDelegate {
  func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
    return 50.0
  }
  
  func pickerView(_ pickerView: PickerView, didTapRow row: Int) {
    switch dateSelector.dateComponentsSelectionMode! {
    case .month:
      dateComponents.month = row + 1
      updateLabel(monthLbl, newValue: dateComponents.month, mode: .month)
    case .day:
      dateComponents.day = row + 1
      updateLabel(dayLbl, newValue: dateComponents.day, mode: .day)
    case .year:
      dateComponents.year = row + 1
      updateLabel(yearLbl, newValue: dateComponents.year, mode: .year)
    }
    dateSelector.dateComponents = dateComponents
    dateSelector.dismiss(animated: true, completion: nil)
  }
  
  func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
    label.textAlignment = .center
    label.textColor = UIColor(red: 233.0/255, green: 160.0/255, blue: 52.0/255, alpha: 1.0)
    
    if highlighted {
      label.font = UIFont(name: "HelveticaNeue-Light", size: 30)
    } else {
      label.font = UIFont(name: "HelveticaNeue-Light", size: 20)
    }
  }
}
