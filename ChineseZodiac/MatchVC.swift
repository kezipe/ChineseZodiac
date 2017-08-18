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
    
    @IBAction func matchButtonPressed(_ sender: Any) {
        let sender: Any!
        if selectedPersons.isEmpty {
            sender = persons
        }
        else if self.selectedPersons.count <= 10 {
            sender = Array(self.selectedPersons)
        } else {
            displayMessage("Please choose 10 or less persons to match")
            return
        }
        performSegue(withIdentifier: "MatchResultVCSegue", sender: sender)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MatchResultVCSegue" {
            if let destination = segue.destination as? MatchResultVC {
                if let sender = sender as? [Person] {
                    destination.persons = sender
                    destination.everyOne = self.persons!
                }
            }
        }
    }
    
    func displayMessage(_ msg: String) {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let label = UILabel(frame: CGRect(x: screenWidth / 2, y: screenHeight - 120 - 21, width: 300, height: 21))
        label.center = CGPoint(x: screenWidth / 2, y: screenHeight - 120 - 21)
        label.textAlignment = .center
        let attrMessage = NSMutableAttributedString(
            string: msg,
            attributes: [NSFontAttributeName:UIFont(
                name: "Helvetica-Bold",
                size: 12.0)!])
        attrMessage.addAttribute(NSForegroundColorAttributeName,
                                 value: Helper.color3,
                                 range: NSRange(location: 0, length: msg.characters.count))
        label.attributedText = attrMessage
        self.view.addSubview(label)
    }
    
    
}

extension MatchVC: PersonColCellDelegate {
    
    func toggleSelectionOfButton(forCell: PersonColCell) {
        if let person = forCell.person {
            if selectedPersons.contains(person) {
                selectedPersons.remove(person)
                forCell.checkMarkImg.isHidden = true
            } else {
//                print("Selected Persons Count (before) = \(String(describing:self.selectedPersons.count))")
                if self.selectedPersons.count >= 10 {
                    displayMessage("You must choose 10 or less persons to match")
                } else {
                    selectedPersons.insert(person)
                    forCell.checkMarkImg.isHidden = false
                }
//                print("Selected Persons Count (after) = \(String(describing:self.selectedPersons.count))")
            }
        }
        for p in selectedPersons {
            print("\(p.name ?? "Error at \(p)")")
        }
    }
}
