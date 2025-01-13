//
//  MatchVCDelegate.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class MatchVCDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    private let sectionInsets = UIEdgeInsets(
        top: 20,
        left: 20,
        bottom: 20,
        right: 20
    )
    weak var parentController: PersonSelecting?

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        parentController?.toggleSelection(forPersonAt: indexPath.item)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        sectionInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        .init(width: 55, height: 99)
    }
}
