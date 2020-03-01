//
//  ZodiacTableViewDelegate.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-20.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit



final class ZodiacTableViewDelegate: NSObject, UITableViewDelegate {
  
  weak var parentController: (PersonPresenting & PersonDeleting)?
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    parentController?.didSelectPerson(at: indexPath.row)
    
  }

  @available(iOS 11.0, *)
  func tableView(_ tableView: UITableView,
                 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
    let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
    return swipeConfig
  }
  
  // iOS 11+
  @available(iOS 11.0, *)
  func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
    
    let action = UIContextualAction(style: .destructive, title: " ") { [weak self] (
      contextAction: UIContextualAction,
      sourceView: UIView,
      completionHandler: (Bool) -> Void) in
      
      self?.parentController?.deletePerson(at: indexPath.row)
    }
    action.image = #imageLiteral(resourceName: "xSymbolW")
    action.backgroundColor = Helper.colorGreen
    return action
  }
  
  // iOS 10 or lower
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

    let kCellActionWidth: CGFloat = 40.0
    let kCellHeight: CGFloat = 60
    let whitespace = " "
    let deleteAction = UITableViewRowAction(style: .default, title: whitespace) { [weak self] (action, indexPath) in
      self?.parentController?.deletePerson(at: indexPath.row)
    }

    // create a color from patter image and set the color as a background color of action
    let kActionImageSize: CGFloat = 34
    let view = UIView(frame: CGRect(x: 0, y: 0, width: kCellActionWidth, height: kCellHeight))
    view.backgroundColor = Helper.colorGreen
    let imageView = UIImageView(frame: CGRect(x: (kCellActionWidth - kActionImageSize) / 2,
                                              y: (kCellHeight - kActionImageSize) / 2,
                                              width: 34,
                                              height: 34))
    imageView.image = UIImage(named: "xSymbol")
    view.addSubview(imageView)
    let image = view.image()

    deleteAction.backgroundColor = UIColor(patternImage: image)

    return [deleteAction]
  }
}
