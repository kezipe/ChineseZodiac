//
//  PopoverVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class PopoverVC: UIViewController {

    var matchVC: MatchVC?
    var persons: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchVC = storyboard?.instantiateViewController(withIdentifier: "MatchVC") as? MatchVC
    }

    @IBAction func matchButtonPressed(_ sender: Any) {
        matchVC?.persons = self.persons
        present(matchVC!, animated: true, completion: nil)
    }

    @IBAction func ToBirthdaySelectionButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ToBirthdaySelectionSegue", sender: nil)
    }

}
