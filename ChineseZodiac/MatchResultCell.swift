//
//  MatchResultCell.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class MatchResultCell: UITableViewCell {

    
    @IBOutlet weak var person1Zodiac: UIImageView!
    @IBOutlet weak var person1Name: UILabel!
    
    @IBOutlet weak var matchScoreLbl: UILabel!
    
    @IBOutlet weak var person2Zodiac: UIImageView!
    @IBOutlet weak var person2Name: UILabel!
    
    private let match = [1:"Poor", 2:"Average", 3:"Good match or Enemy", 4:"Good friend", 5:"Complementary", 6: "Perfect Match"]
    
    func configureCell(pair: [Person]) {
        let p1Zodiac = Int(pair[0].zodiac)
        let p2Zodiac = Int(pair[1].zodiac)
        let score = Helper.match(person1: p1Zodiac, person2: p2Zodiac)
        person1Zodiac.image = UIImage(named: "\(Helper.getZodiac(fromIndex: p1Zodiac))")
        person1Name.text = pair[0].name
        
        matchScoreLbl.text = match[score]
        
        person2Zodiac.image = UIImage(named: "\(Helper.getZodiac(fromIndex: p2Zodiac))")
        person2Name.text = pair[1].name
        
        layer.cornerRadius = 8.0
        
        guard score == 6 else {
            return
        }
        layer.borderWidth = 2.0
        layer.borderColor = Helper.color2.cgColor
        matchScoreLbl.textColor = Helper.color2
        
        
    }

}
