//
//  DetailsVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-04.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class DetailsVC: UIViewController {
  
  
  @IBOutlet weak var deleteButton: UIButton!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  
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
  
  @IBAction func cancelButtonPressed(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if(self.isEditing) {
      self.editButtonItem.title = "Done"
      deleteButton.isHidden = false
    } else {
      self.editButtonItem.title = "Edit"
      deleteButton.isHidden = true
    }
  }
  
  
  @IBAction func EditButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: "EditPerson", sender: self.person)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "EditPerson" else {
      return
    }
    guard let destination = segue.destination as? BirthdaySelectionView else {
      return
    }
    
    guard let person = sender as? Person else {
      return
    }
    
    destination.personToEdit = person
    
  }
  
  
}
