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
    let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath, tableView: tableView)
    let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
    return swipeConfig
  }
  
  // iOS 11+
  @available(iOS 11.0, *)
  func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath, tableView: UITableView) -> UIContextualAction {
    
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (
      contextAction: UIContextualAction,
      sourceView: UIView,
      completionHandler: (Bool) -> Void) in
      self?.parentController?.deletePerson(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .left)
    }
    return deleteAction
  }
  
  // iOS 10 or lower
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
      self?.parentController?.deletePerson(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .left)
    }
    return [deleteAction]
  }
}
