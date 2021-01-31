//
//  MatchVCDelegate.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class MatchVCDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  weak var parentController: PersonSelecting?
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    parentController?.toggleSelection(forPersonAt: indexPath.item)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt
      section: Int
  ) -> UIEdgeInsets {
    .init(top: 8, left: 8, bottom: 8, right: 8)
  }
}
