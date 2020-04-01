//
//  DetailsVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-04.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class DetailsVC: UIViewController {

  var person: Person?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateInformation()
  }
  
  fileprivate func updateInformation() {
    guard let person = person else {
      return
    }
    guard let view = view as? DetailsView else {
      return
    }
    view.updateInformation(forPerson: person)
  }
  
  @IBAction func deleteButtonPressed(_ sender: Any) {
    if let person = person {
      PersonDataManager.shared.delete(person)
      navigateToParentController()
    }
  }
  
  fileprivate func navigateToParentController() {
    navigationController?.popViewController(animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "EditPerson" else {
      return
    }
    guard let destination = segue.destination as? BirthdaySelectionViewController else {
      return
    }
    
    guard let person = sender as? Person else {
      return
    }
    
    destination.personToEdit = person
    
  }
  
  
}
