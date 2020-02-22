//
//  MatchVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class MatchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var matchStackView: UIStackView!
    @IBOutlet weak var matchButtonText: UILabel!
    @IBOutlet weak var matchButtonImg: UIImageView!
    
    var persons: [Person]?
    var selectedPersons: Set<Person> = []
    var validSelection: Bool {
        if let persons = persons {
            return selectedPersons.isEmpty && persons.count <= 10 || selectedPersons.count <= 10 && !selectedPersons.isEmpty
        } else {
            return false
        }
    }
    var displayingMessage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .background).async {
            let persons = PersonDao.retrieveData(sortBy: .name).fetchedObjects!
            if persons != self.persons {
                DispatchQueue.main.async {
                    self.persons = persons
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let persons = self.persons else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonColCell", for: indexPath) as! PersonColCell
        cell.configureCell(person: persons[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let personsCount = persons?.count {
            return personsCount
        } else {
            return 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MatchResultVCSegue" {
            if let destination = segue.destination as? MatchResultVC {
                if validSelection {
                    if selectedPersons.isEmpty {
                        destination.persons = persons!
                    } else {
                        destination.persons = Array(selectedPersons)
                    }
                }
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "MatchResultVCSegue" {
            if !validSelection {
                displayMessage("Please choose 10 or less persons to match")
                return false
            }
            return true
        }
        return false
    }
    
    func displayMessage(_ msg: String) {
        guard !displayingMessage else { return }
        displayingMessage = true
        matchButtonImg.isHidden = true
        
        let attrMessage = NSMutableAttributedString(
            string: msg,
            attributes: [NSAttributedString.Key.font:UIFont(
                name: "Helvetica-Bold",
                size: 15.0)!])
        attrMessage.addAttribute(NSAttributedString.Key.foregroundColor,
                                 value: UIColor.white,
                                 range: NSRange(location: 0, length: msg.count))
        matchButtonText.attributedText = attrMessage
        matchStackView.bounds = matchStackView.bounds.offsetBy(dx: 0, dy: 5)


        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.matchStackView.bounds = self.matchStackView.bounds.offsetBy(dx: 0, dy: -5)
            self.matchButtonText.attributedText = nil
            self.matchButtonText.text = "Match"
            self.matchButtonImg.isHidden = false
            self.displayingMessage = false
        }
    }
}

extension MatchVC: PersonColCellDelegate {
    
    func toggleSelectionOfButton(forCell: PersonColCell) {
        if let person = forCell.person {
            if selectedPersons.contains(person) {
                selectedPersons.remove(person)
                forCell.checkMarkImg.isHidden = true
            } else {
                if self.selectedPersons.count >= 10 {
                    displayMessage("You must choose 10 or less persons to match")
                } else {
                    selectedPersons.insert(person)
                    forCell.checkMarkImg.isHidden = false
                }
            }
        }
    }
}
