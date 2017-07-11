//
//  PersonColCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class PersonColCell: UICollectionViewCell {
    @IBOutlet weak var zodiacImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var checkMarkImg: UIImageView!
    
    var checkMarkView: SSCheckMark!

    func configureCell(person: Person) {
        nameLbl.text = person.name
        let birthday = person.birthdate! as Date
        zodiacImg.image = UIImage(named: "\(birthday.getZodiac())_thumb")
        checkMarkView = SSCheckMark(frame: CGRect(x: frame.width - 40, y: 10, width: 35, height: 35))
        checkMarkView.backgroundColor = UIColor.clear
        print("checkMarkView initialized")
        self.addSubview(checkMarkView)
    }
    
    func selectCell() {
        checkMarkImg.isHidden = false
    }
    
    func deselectCell() {
        checkMarkImg.isHidden = true
    }
    
    func toggleSelection() {
        checkMarkImg.isHidden = !checkMarkImg.isHidden
    }
}
