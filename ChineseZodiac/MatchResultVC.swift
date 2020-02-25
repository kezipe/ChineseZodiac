//
//  MatchResultVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class MatchResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var persons: [Person]?
    var match: Match?
    var loner: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchUp()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func matchUp() {
        DispatchQueue.global(qos: .background).async {
            let match = Match(personsArray: self.persons!)
            self.loner = match.loner
            self.match = match
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let match = match else { return UITableViewCell() }
        
        if self.loner != nil && indexPath.row == persons!.count / 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatchResultLonerCell") as! MatchResultLonerCell
            cell.configureCell(person: loner!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatchResultCell") as! MatchResultCell
            cell.configureCell(pair: match.matches![indexPath.row])
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return match == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard match != nil else { return 0 }
        
        if self.loner != nil {
            return persons!.count / 2 + 1
        } else {
            return persons!.count / 2
        }
    }
    
    @IBAction func backButtonPresed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension MatchResultVC: PersonsReceivable {
  func receive(persons: [Person]) {
    self.persons = persons
  }
}
