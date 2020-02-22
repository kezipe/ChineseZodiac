//
//  ZodiacSignView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class ZodiacSignView: UIViewController {
    
    var birthdate: Date?
    
    @IBOutlet weak var cDateLbl: UILabel!
    @IBOutlet weak var zodiacSignLbl: UILabel!
    @IBOutlet weak var zodiacImg: UIImageView!

    @IBAction func addPersonButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backToZodiacTableView(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cBirthdayString = birthdate?.getZodiacChar() {
            cDateLbl.text = cBirthdayString
        }
        
        if let zodiacSign = birthdate?.getZodiac() {
            zodiacSignLbl.text = zodiacSign
            zodiacImg.image = UIImage(named: "\(zodiacSign)")
        }
    }
    
    
}

