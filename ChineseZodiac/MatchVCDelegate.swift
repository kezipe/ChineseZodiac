//
//  MatchVCDelegate.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class MatchVCDelegate: NSObject, UICollectionViewDelegate {
  weak var parentController: PersonSelecting?
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    parentController?.toggleSelection(forPersonAt: indexPath.item)
  }
}
