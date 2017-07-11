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
    var selectedPersons: [Person]!
    var selected = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonColCell", for: indexPath) as! PersonColCell
        cell.configureCell(person: persons[indexPath.row])
        cell.checkMarkView.checked = selected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = !selected
        print("\(selected ? "Seleted" : "Deselected")")
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonColCell", for: indexPath) as! PersonColCell
//        cell.selectCell()
    }


}
