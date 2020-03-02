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
  
  var personToEdit: Person?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func dateChanged(_ sender: Any) {
    updateImage()
    updateLabel()
  }
  
  func updateImage() {
    let date = datePicker.date
    let zodiacName = date.getZodiac().name
    if let image = UIImage(named: zodiacName) {
      zodiacImage.image = image
    }
  }
  
  func updateLabel() {
    let date = datePicker.date
    let zodiacName = date.getZodiac().name
    zodiacLabel.text = zodiacName
  }

  @IBAction func saveButtonPressed(_ sender: Any) {
    print(123)
  }
}




