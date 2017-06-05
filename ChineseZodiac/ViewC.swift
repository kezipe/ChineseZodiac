//
//  ViewController.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class ViewC: UIViewController {
    
    var birthdate: Date?
    
    @IBOutlet weak var dateLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLbl.isHidden = true
        dateLbl.text = birthdate?.format(calendarId: Calendar.current.identifier)
    }


}

