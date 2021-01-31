//
//  MatchVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-08.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

enum MatchButtonState: String {
  case createNewPerson
  case requestSelectMorePeople
  case matchAll
  case matchSelected
}

final class MatchVC: UIViewController, UICollectionViewDelegateFlowLayout {
  private lazy var collectionView: UICollectionView = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: collectionViewLayout
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  private lazy var matchButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.text = "Match"
    NSLayoutConstraint.activate(
      [
        button.heightAnchor.constraint(equalToConstant: 44)
      ]
    )
    return button
  }()

  fileprivate lazy var dataSource = MatchVCDataSource()
  fileprivate lazy var delegate = MatchVCDelegate()
  private var matchButtonState = MatchButtonState.matchAll

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupButtonAction()
    let dataManager = PersonDataManager.shared
    dataSource.dataManager = dataManager
    collectionView.dataSource = dataSource
    delegate.parentController = self
    collectionView.delegate = delegate
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.collectionView.reloadData()
    self.updateMatchButton()
    self.updateDeselectAllButton()
  }

  private func setupUI() {
    view.addSubview(collectionView)
    view.addSubview(matchButton)
    let multiplier: CGFloat = 1.0
    NSLayoutConstraint.activate(
      [
        matchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      ]
    )
    if #available(iOS 11, *) {
      NSLayoutConstraint.activate(
        [
          collectionView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor
          ),
          collectionView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor
          ),
          view.safeAreaLayoutGuide.trailingAnchor.constraint(
            equalTo: collectionView.trailingAnchor
          ),
          matchButton.topAnchor.constraint(
            equalToSystemSpacingBelow: collectionView.bottomAnchor,
            multiplier: 1
          ),
          matchButton.leadingAnchor.constraint(
            equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
            multiplier: 1
          ),
          view.safeAreaLayoutGuide.trailingAnchor.constraint(
            equalToSystemSpacingAfter: matchButton.leadingAnchor,
            multiplier: 1
          ),
          view.safeAreaLayoutGuide.bottomAnchor.constraint(
            equalToSystemSpacingBelow: matchButton.bottomAnchor,
            multiplier: 1
          )
        ]
      )
    } else {
      NSLayoutConstraint.activate(
        [
          collectionView.topAnchor.constraint(equalTo: view.topAnchor),
          collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          view.trailingAnchor.constraint(
            equalTo: collectionView.trailingAnchor
          ),
          matchButton.topAnchor.constraint(
            equalTo: collectionView.bottomAnchor,
            constant: 8 * multiplier
          ),
          matchButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 8 * multiplier
          ),
          view.trailingAnchor.constraint(
            equalTo: matchButton.trailingAnchor,
            constant: 8 * multiplier
          ),
          view.bottomAnchor.constraint(
            equalTo: matchButton.bottomAnchor,
            constant: 8 * multiplier
          )
        ]
      )
    }
  }
  
  private func setupButtonAction() {
    matchButton.addTarget(self, action: #selector(matchButtonPressed), for: .touchUpInside)
  }
  
  @objc func matchButtonPressed() {
    switch matchButtonState {
    case .createNewPerson:
      createNewPerson()
    case .matchAll, .matchSelected:
      match()
    case .requestSelectMorePeople:
      break
    }
  }
  
  fileprivate func createNewPerson() {
    let BIRTHDAY_SELECTION_VIEW = "BirthdaySelectionView"
    let birthdaySelectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: BIRTHDAY_SELECTION_VIEW)
    navigationController?.pushViewController(birthdaySelectionViewController, animated: true)
  }
  
  fileprivate func match() {
    let resultsVC = MatchResultVC()
    dataSource.send(to: resultsVC)
    navigationController?.pushViewController(resultsVC, animated: true)
  }
  
  @IBAction func deselectAll(_ sender: Any) {
    dataSource.deselectAll()
    collectionView.reloadData()
    updateMatchButton()
    updateDeselectAllButton()
  }
  
  fileprivate func updateMatchButton() {
    let personsSelected = dataSource.numberOfSelectedItems
    let hasNooneSelected = personsSelected == 0
    
    if hasNooneSelected {
      if dataSource.canMatchAll() {
        matchButton.setTitle("Match All", for: .normal)
        matchButtonState = .matchAll
        enableMatchButton()
      } else if dataSource.numberOfItems < 2 {
        matchButton.setTitle("Create New Person", for: .normal)
        matchButtonState = .createNewPerson
        enableMatchButton()
      } else {
        matchButton.setTitle("Please select 2 to 10 people", for: .normal)
        matchButtonState = .requestSelectMorePeople
        disableMatchButton()
      }
    } else if dataSource.isSelectionLegal() {
      matchButton.setTitle("Match \(personsSelected)", for: .normal)
      matchButtonState = .matchSelected
      enableMatchButton()
    } else {
      matchButton.setTitle("Please select 2 to 10 people", for: .normal)
      matchButtonState = .requestSelectMorePeople
      disableMatchButton()
    }
  }
  
  fileprivate func updateDeselectAllButton() {
    let personsSelected = dataSource.numberOfSelectedItems
    let hasNooneSelected = personsSelected == 0
    
    if hasNooneSelected {
      disableDeselectButton()
    } else {
      enableDeselectButton()
    }
  }
  
  fileprivate func disableDeselectButton() {
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
  
  fileprivate func enableDeselectButton() {
    navigationItem.rightBarButtonItem?.isEnabled = true
  }
  
  
  fileprivate func enableMatchButton() {
    matchButton.isEnabled = true
    UIView.animate(withDuration: 0.5) {
      self.matchButton.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
    }
  }
  
  fileprivate func disableMatchButton() {
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
    updateDeselectAllButton()
  }
  
  fileprivate func reloadPerson(at item: Int) {
    let indexPathsToReload = [IndexPath(item: item, section: 0)]
    collectionView.reloadItems(at: indexPathsToReload)
  }
  
}
