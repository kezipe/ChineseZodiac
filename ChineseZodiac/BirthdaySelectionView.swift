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

final class BirthdaySelectionView: UIViewController {
  
  private let DATE_SELECTOR_IDENTIFIER = "DateSelectorVC"
  private let ZODIAC_SIGN_IDENTIFIER = "ToZodiacSignView"
  private let DEFAULT_FONT_COLOR = UIColor.init(red: 233.0/255, green: 160.0/255, blue: 52.0/255, alpha: 1.0)
  
  
  var dateComponents = DateComponents()
  var dateSelector: DateSelectorVC!
  var personToEdit: Person?
  
  @IBOutlet weak var monthLbl: UIButton!
  @IBOutlet weak var dayLbl: UIButton!
  @IBOutlet weak var yearLbl: UIButton!
  @IBOutlet weak var nameWarningLbl: UILabel!
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var nameField: UITextField!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dateSelector = storyboard?.instantiateViewController(withIdentifier: DATE_SELECTOR_IDENTIFIER) as? DateSelectorVC
    dateSelector.dateComponents = dateComponents
    dateSelector.parentController = self
    
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
    let isKeyboardGoingDown = notification.name == UIResponder.keyboardWillHideNotification
    let movementDistance: CGFloat
    
    if #available(iOS 11, *) {
      movementDistance = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
    } else {
      movementDistance = keyboardViewEndFrame.height
    }
    
    shiftView(down: isKeyboardGoingDown, distance: movementDistance)
  }
  
  func shiftView(down: Bool, distance: CGFloat) {
    if down {
      self.view.transform = .identity
    } else {
      self.view.transform = CGAffineTransform(translationX: 0, y: -distance)
    }
  }
  
  @IBAction func selectMonth(_ sender: Any) {
    dateSelector.dateComponentsSelectionMode = .month
    present(dateSelector, animated: true)
  }
  
  @IBAction func selectDay(_ sender: Any) {
    dateSelector.dateComponentsSelectionMode = .day
    present(dateSelector, animated: true)
  }
  
  @IBAction func selectYear(_ sender: Any) {
    dateSelector.dateComponentsSelectionMode = .year
    present(dateSelector, animated: true)
  } 
  
  
  func loadData() {
    if let person = personToEdit,
      let personName = person.name,
      let birthdate = person.birthdate {
      
      prepareDateComponents(from: birthdate)
      updateDateSelectorDateComponents()
      updateNameTextField(with: personName)
    } else {
      updateNameLabelText()
    }
    
    updateLabels()
  }
  
  func prepareDateComponents(from date: Date) {
    let df = DateFormatter()
    df.dateFormat = "yyyy"
    dateComponents.year = Int(df.string(from: date))!
    df.dateFormat = "M"
    dateComponents.month = Int(df.string(from: date))!
    df.dateFormat = "d"
    dateComponents.day = Int(df.string(from: date))!
  }
  
  func updateDateSelectorDateComponents() {
    dateSelector.dateComponents = dateComponents
  }
  
  func updateNameTextField(with text: String) {
    nameField.text = text
  }
  
  func shouldDisplayPersonsName(_ name: String) -> Bool {
    return 1 ..< 16 ~= name.count
  }
  
  func updateNameLabelText(with name: String? = nil) {
    if let name = name, shouldDisplayPersonsName(name) {
      nameLbl.text = "\(name)'s birthday:"
    } else {
      nameLbl.text = "Birthday:"
    }
  }
  
  fileprivate func updateDayValue(to value: Int) {
    dateComponents.day = value
    updateLabel(dayLbl, newValue: value, mode: .day)
  }
  
  fileprivate func updateMonthValue(to value: Int) {
    dateComponents.month = value
    updateLabel(monthLbl, newValue: value, mode: .month)
  }
  
  fileprivate func updateYearValue(to value: Int) {
    dateComponents.year = value
    updateLabel(yearLbl, newValue: value, mode: .year)
  }
  
  func updateLabels() {
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
      label.setTitleColor(DEFAULT_FONT_COLOR, for: .normal)
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
    monthLbl.setTitleColor(DEFAULT_FONT_COLOR, for: UIControl.State.normal)
    
    guard dayLbl.title(for: UIControl.State.normal) != "Day" else {
      dayLbl.setTitleColor(UIColor.red, for: UIControl.State.normal)
      return
    }
    dayLbl.setTitleColor(DEFAULT_FONT_COLOR, for: UIControl.State.normal)
    
    guard yearLbl.title(for: UIControl.State.normal) != "Year" else {
      yearLbl.setTitleColor(UIColor.red, for: UIControl.State.normal)
      return
    }
    yearLbl.setTitleColor(DEFAULT_FONT_COLOR, for: UIControl.State.normal)
    
    validateFormAndPerformSegue()
  }
  
  @IBAction func nameFieldEditingChanged(_ sender: UITextField) {
    updateNameLabelText(with: sender.text)
  }
  
  func validateFormAndPerformSegue() {
    if isNameFieldEmpty() {
      askToFillName()
    } else {
      prepareToSavePerson()
      savePerson()
      
      performSegue(withIdentifier: ZODIAC_SIGN_IDENTIFIER, sender: dateComponents.date)
    }
  }
  
  func isNameFieldEmpty() -> Bool {
    return nameField.text == ""
  }
  
  func askToFillName() {
    nameWarningLbl.isHidden = false
    nameField.becomeFirstResponder()
  }
  
  func prepareToSavePerson() {
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
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == ZODIAC_SIGN_IDENTIFIER else {
      return
    }
    
    guard let destination = segue.destination as? ZodiacSignView else {
      return
    }
    
    guard let date = sender as? Date else {
      return
    }
    
    destination.birthdate = date
    nameField.resignFirstResponder()
  }
  
}

extension BirthdaySelectionView: PersonSaving {
  func savePerson() {
    ad.saveContext()
  }
}

extension BirthdaySelectionView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    validateFormAndPerformSegue()
    return true
  }
}

extension BirthdaySelectionView: DatePickable {
  

  
  func selectRow(at row: Int, mode: DateComponentSelectionMode) {
    switch mode {
    case .month:
      updateMonthValue(to: row + 1)
    case .day:
      updateDayValue(to: row + 1)
    case .year:
      updateYearValue(to: row + 1)
    }
    
    if let month = dateComponents.month, let day = dateComponents.day {
      
      let year = dateComponents.year ?? 2000
      let numberOfDaysForGivenMonth = month.toNumDaysInMonth(year: year)
      if numberOfDaysForGivenMonth < day {
        updateDayValue(to: numberOfDaysForGivenMonth)
      }
      
    }
    
    dateSelector.dateComponents = dateComponents
    dateSelector.dismiss(animated: true, completion: nil)
  }
  

}




