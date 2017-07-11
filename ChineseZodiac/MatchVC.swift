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
    var selected = false

    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
    }


}

extension MatchVC: PersonColCellDelegate {
    
    func toggleSelectionOfButton(forCell: PersonColCell) {
        forCell.checkMarkImg.isHidden = !forCell.checkMarkImg.isHidden
        if selectedPersons.contains(forCell.person!) {
            selectedPersons.remove(forCell.person!)
        } else {
            selectedPersons.insert(forCell.person!)
        }
        for p in selectedPersons {
            print("\(p.name ?? "Error at \(p)")")
        }
    }
}
