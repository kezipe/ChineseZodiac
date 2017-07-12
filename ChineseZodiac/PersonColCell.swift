//
//  PersonColCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

protocol PersonColCellDelegate {
    func toggleSelectionOfButton(forCell: PersonColCell)
}

class PersonColCell: UICollectionViewCell {
    @IBOutlet weak var zodiacImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var checkMarkImg: UIImageView!
    
    var button: UIButton!
    var delegate: PersonColCellDelegate? = nil
    var person: Person?

    
    func configureCell(person: Person) {
        self.person = person
        nameLbl.text = person.name
        let birthday = person.birthdate! as Date
        zodiacImg.image = UIImage(named: "\(birthday.getZodiac())_thumb")
        button = UIButton(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.width))
        button.backgroundColor = UIColor.clear
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(toggleSelection), for: .touchUpInside)
        contentView.addSubview(button)
    }
    
    func toggleSelection() {
        print("PersonColCellDelegate: Toggling visibility of checkmark")
        delegate?.toggleSelectionOfButton(forCell: self)
    }

}
