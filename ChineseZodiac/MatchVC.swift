//
//  MatchVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class MatchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!

    var persons: [Person]!
    var selectedPersons: Set<Person> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonColCell", for: indexPath) as! PersonColCell
        cell.configureCell(person: persons[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }


}

extension MatchVC: PersonColCellDelegate {
    
    func toggleSelectionOfButton(forCell: PersonColCell) {
        if let person = forCell.person {
            if selectedPersons.contains(person) {
                selectedPersons.remove(person)
                forCell.checkMarkImg.isHidden = true
            } else {
                selectedPersons.insert(person)
                forCell.checkMarkImg.isHidden = false
            }
        }
        for p in selectedPersons {
            print("\(p.name ?? "Error at \(p)")")
        }
    }
}
