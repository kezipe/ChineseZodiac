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
  @IBOutlet weak var matchButton: UIButton!
  
  fileprivate lazy var dataSource = MatchVCDataSource()
  fileprivate lazy var delegate = MatchVCDelegate()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = dataSource
    delegate.parentController = self
    collectionView.delegate = delegate
  }
  
  override func viewDidAppear(_ animated: Bool) {
    DispatchQueue.global(qos: .background).async {
      self.fetchNewData()
    }
  }
  
  fileprivate func fetchNewData() {
    dataSource.fetchData()
    DispatchQueue.main.async {
      self.collectionView.reloadData()
      self.updateMatchButton()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "MatchResultVCSegue" else {
      return
    }
    guard let destination = segue.destination as? PersonsReceivable else {
      return
    }
    dataSource.send(to: destination)
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    guard identifier == "MatchResultVCSegue" else {
      return false
    }
    return true
  }
  
  @IBAction func deselectAll(_ sender: Any) {
    dataSource.deselectAll()
    collectionView.reloadData()
  }
  
  fileprivate func updateMatchButton() {
    let personsSelected = dataSource.numberOfSelectedItems
    let hasNooneSelected = personsSelected == 0
    
    if hasNooneSelected {
      if dataSource.canMatchAll() {
        matchButton.setTitle("Match All", for: .normal)
        enableMatchButton()
      } else {
        disableMatchButton()
      }
    } else if dataSource.isSelectionLegal() {
      matchButton.setTitle("Match \(personsSelected)", for: .normal)
      enableMatchButton()
    } else {
      disableMatchButton()
    }
  }
  
  fileprivate func enableMatchButton() {
    matchButton.isEnabled = true
    UIView.animate(withDuration: 0.5) {
      self.matchButton.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
    }
  }
  
  fileprivate func disableMatchButton() {
    matchButton.setTitle("Please select 2 to 10 people", for: .normal)
    matchButton.isEnabled = false
    UIView.animate(withDuration: 0.5) {
      self.matchButton.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
    }
  }
  
  fileprivate func highlightPerson(at item: Int) {
    let indexPath = IndexPath(item: item, section: 0)
    let cell = collectionView.cellForItem(at: indexPath) as! PersonCollectionCell
    cell.highlightPerson()
  }
  
  fileprivate func dehighlightPerson(at item: Int) {
    let indexPath = IndexPath(item: item, section: 0)
    let cell = collectionView.cellForItem(at: indexPath) as! PersonCollectionCell
    cell.dehighlightPerson()
  }

}

extension MatchVC: PersonSelecting {
  
  func toggleSelection(forPersonAt item: Int) {
    selectPerson(item)
    reloadPerson(at: item)
  }
  
  
  fileprivate func selectPerson(_ item: Int) {
    dataSource.tapPerson(at: item)
    updateMatchButton()
  }
  
  fileprivate func reloadPerson(at item: Int) {
    let indexPathsToReload = [IndexPath(item: item, section: 0)]
    collectionView.reloadItems(at: indexPathsToReload)
  }
  
}
