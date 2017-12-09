//
//  MatchResultVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class MatchResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var persons: [Person]?
    var everyOne: [Person]?
    var match: Match!
    var loner: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        match = Match(personsArray: persons!)
        if let loner = match.loner {
            self.loner = loner
//            print("Loner is \(self.loner!.name ?? "No Loner")")
        }
        
        

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("Now configuring \(indexPath.row) and self.loner != nil is \(self.loner != nil) and indexPath.row == persons!.count / 2 + 1 is \(indexPath.row == persons!.count / 2)")
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.loner != nil {
//            print("numberOfRowsInSection = \(persons!.count / 2 + 1)")
            return persons!.count / 2 + 1
        } else {
            return persons!.count / 2
        }
    }
    
    @IBAction func backButtonPresed(_ sender: Any) {
        performSegue(withIdentifier: "BackToCollectionView", sender: self.everyOne!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MatchVC {
            destination.persons = sender as! [Person]
        }
    }
    
    
}
