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
  
  
  fileprivate let ERROR_MESSAGE = "Please choose 10 or less persons to match"
  fileprivate let ERROR_MESSAGE_FONT = UIFont(name: "Helvetica-Bold", size: 15.0)!
  fileprivate lazy var dataSource = MatchVCDataSource()
  fileprivate lazy var delegate = MatchVCDelegate()
  fileprivate var displayingMessage = false
  
  fileprivate var hasValidSelection: Bool {
    dataSource.hasValidSelection()
  }
  
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
    guard hasValidSelection else {
      return
    }
    dataSource.send(to: destination)
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    guard identifier == "MatchResultVCSegue" else {
      return false
    }
    guard hasValidSelection else {
      displayMessage(ERROR_MESSAGE)
      return false
    }
    return true
  }
  
  fileprivate func displayMessage(_ msg: String) {
    guard !displayingMessage else {
      return
    }
    
    showErrorMessage(msg)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.hideErrorMessage()
    }
  }
  
  fileprivate func hideErrorMessage() {
    if displayingMessage {
      matchStackView.bounds = self.matchStackView.bounds.offsetBy(dx: 0, dy: -5)
      matchButtonText.attributedText = nil
      matchButtonText.text = "Match"
      matchButtonImg.isHidden = false
      displayingMessage = false
    }
  }
  
  fileprivate func showErrorMessage(_ message: String) {
    displayingMessage = true
    matchButtonImg.isHidden = true
    
    let attrMessage = createErrorMessage(message)
    
    matchButtonText.attributedText = attrMessage
    matchStackView.bounds = matchStackView.bounds.offsetBy(dx: 0, dy: 5)
  }
  
  fileprivate func createErrorMessage(_ message: String) -> NSAttributedString {
    let attrMessage = NSMutableAttributedString(
      string: message,
      attributes: [NSAttributedString.Key.font: ERROR_MESSAGE_FONT])
    
    attrMessage.addAttribute(NSAttributedString.Key.foregroundColor,
                             value: UIColor.white,
                             range: NSRange(location: 0, length: message.count))
    return attrMessage
  }
  
}

extension MatchVC: PersonSelecting {
  
  func toggleSelection(forPersonAt item: Int) {
    trySelectingPerson(item)
    reloadPerson(at: item)
  }
  
  fileprivate func trySelectingPerson(_ item: Int) {
    do {
      try dataSource.tapPerson(at: item)
    } catch MatchError.tooManySelected(let max) {
      displayMessage("You must choose \(max) or less persons to match")
    } catch {
      print("Unexpected error: \(error).")
    }
  }
  
  fileprivate func reloadPerson(at item: Int) {
    let indexPathsToReload = [IndexPath(item: item, section: 0)]
    collectionView.reloadItems(at: indexPathsToReload)
  }
  
}
