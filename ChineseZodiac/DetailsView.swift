//
//  DetailsView.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-21.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class DetailsView: UIView {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var zodiacImg: UIImageView!
  @IBOutlet weak var nameLbl: UILabel!
  fileprivate var dataSource = DetailsVCTableViewDataSource()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func updateInformation(forPerson person: Person) {
    
    if let name = person.name, let birthday = person.birthdate {
      let zodiacSign = birthday.getZodiac()
      
      updateNameLabel(name)
      updateZodiacImage(zodiacSign.name)
      dataSource.person = person
      tableView.dataSource = dataSource
    }
  }
  
  fileprivate func updateZodiacImage(_ zodiacSign: String) {
    zodiacImg.image = UIImage(named: zodiacSign)
  }
  
  fileprivate func updateNameLabel(_ name: String) {
    nameLbl.text = name
  }
  
}
