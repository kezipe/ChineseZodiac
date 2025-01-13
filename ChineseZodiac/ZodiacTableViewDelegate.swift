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
}
