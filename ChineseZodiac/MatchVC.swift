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
  @IBOutlet weak var matchButtonText: UILabel!
  
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
  
}

extension MatchVC: PersonSelecting {
  
  func toggleSelection(forPersonAt item: Int) {
    selectPerson(item)
    reloadPerson(at: item)
  }
  
  fileprivate func selectPerson(_ item: Int) {
    dataSource.tapPerson(at: item)
  }
  
  fileprivate func reloadPerson(at item: Int) {
    let indexPathsToReload = [IndexPath(item: item, section: 0)]
    collectionView.reloadItems(at: indexPathsToReload)
  }
  
}
