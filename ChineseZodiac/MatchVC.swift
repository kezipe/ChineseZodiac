//
//  MatchVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class MatchVC: UIViewController, UICollectionViewDelegateFlowLayout {
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet weak var matchStackView: UIStackView!
  @IBOutlet weak var matchButtonText: UILabel!
  @IBOutlet weak var matchButtonImg: UIImageView!
  
  private lazy var dataSource = MatchVCDataSource()
  private lazy var delegate = MatchVCDelegate()
  
  private let ERROR_MESSAGE = "Please choose 10 or less persons to match"
  
  var persons: [Person] = []
  var selectedPersons: Set<Person> = []

  var displayingMessage = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = dataSource
    
    delegate.parentController = self
    collectionView.delegate = delegate
  }
  
  override func viewDidAppear(_ animated: Bool) {
    fetchNewData()
  }
  
  func fetchNewData() {
    DispatchQueue.global(qos: .background).async {
      if let persons = PersonDataRetriever.shared.retrieveData(sortBy: .name) {
        guard persons != self.persons else {
          return
        }
        self.dataSource.fillData(persons)
        DispatchQueue.main.async {
          self.persons = persons
          self.collectionView.reloadData()
        }
      }
    }
  }
  
  func validateSelection() -> Bool {
    return selectedPersons.isEmpty && persons.count <= 10 || selectedPersons.count <= 10 && !selectedPersons.isEmpty
  }
  
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "MatchResultVCSegue" else {
      return
    }
    guard let destination = segue.destination as? MatchResultVC else {
      return
    }
    guard validateSelection() else {
      return
    }
    
    if selectedPersons.isEmpty {
      destination.persons = persons
    } else {
      destination.persons = Array(selectedPersons)
    }
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    guard identifier == "MatchResultVCSegue" else {
      return false
    }
    
    guard validateSelection() else {
      displayMessage(ERROR_MESSAGE)
      return false
    }
    
    return true
  }
  
  func displayMessage(_ msg: String) {
    guard !displayingMessage else {
      return
    }
    
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

extension MatchVC: PersonSelecting {
  
  func toggleSelection(forPersonAt item: Int) {
    let personTapped = dataSource.person(at: item)
    if selectedPersons.contains(personTapped) {
      selectedPersons.remove(personTapped)
      hideCheckMark(at: item)
    } else {
      if self.selectedPersons.count >= 10 {
        displayMessage("You must choose 10 or less persons to match")
      } else {
        selectedPersons.insert(personTapped)
        showCheckMark(at: item)
      }
    }
  }
  
  func cell(for item: Int) -> PersonColCell {
    if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? PersonColCell {
      return cell
    } else {
      fatalError("Cannot fetch CollectionViewCell for item at \(item)")
    }
  }
  
  func showCheckMark(at item: Int) {
    cell(for: item).checkMarkImg.isHidden = false
  }
  
  func hideCheckMark(at item: Int) {
    cell(for: item).checkMarkImg.isHidden = true
  }
  
}
