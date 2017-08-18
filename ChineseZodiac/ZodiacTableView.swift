//
//  TableView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit
import CoreData

class ZodiacTableView: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    var persons = [Person]()
    var controller: NSFetchedResultsController<Person>!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        retrieveData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveData()
        tableView.reloadData()
    }
    
    func retrieveData() {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let zodiacSort = NSSortDescriptor(key: "zodiac", ascending: true)
        let birthdateSort = NSSortDescriptor(key: "birthdate", ascending: false)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [dateSort]
        } else if segmentedControl.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [nameSort]
        } else if segmentedControl.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [zodiacSort]
        } else if segmentedControl.selectedSegmentIndex == 3 {
            fetchRequest.sortDescriptors = [birthdateSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
        self.controller = controller
        self.persons = controller.fetchedObjects!
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        retrieveData()
        tableView.reloadData()
    }
    
    
    // MARK: Cell Management
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let kCellActionWidth: CGFloat = 40.0
        let kCellHeight: CGFloat = 60
        let whitespace = "  "
        let deleteAction = UITableViewRowAction(style: .`default`, title: whitespace) { (action, indexPath) in
            let person = self.persons[indexPath.row]
            context.delete(person)
            ad.saveContext()
            
            do {
                self.persons = try context.fetch(Person.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
            self.retrieveData()
            tableView.reloadData()
        }
        
        // create a color from patter image and set the color as a background color of action
        let kActionImageSize: CGFloat = 34
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kCellActionWidth, height: kCellHeight))
        view.backgroundColor = UIColor(red: 249.0/255, green: 211.0/255, blue: 65.0/255, alpha: 1.0)
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
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! PersonCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
        
    }
    
    // MARK: Table View Stuff
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTable", for: indexPath) as! PersonCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
        
    }
    
    func configureCell(cell: PersonCell, indexPath: NSIndexPath) {
        let person = controller.object(at: indexPath as IndexPath)
        cell.configureCell(person: person)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsVC", sender: persons[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.layer.backgroundColor = Helper.color4.cgColor
        cell?.layer.cornerRadius = 8.0
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.layer.backgroundColor = Helper.color5.cgColor
        cell?.layer.cornerRadius = 8.0
    }
    
    // MARK: Prepare for segue and Popover
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsVC" {
            if let destination = segue.destination as? DetailsVC {
                if let person = sender as? Person {
                    destination.person = person
                }
            }
        } else if segue.identifier == "showPopover" {
            if let destination = segue.destination as? PopoverVC {
                if let persons = sender as? [Person] {
                    destination.persons = persons
                }
                destination.popoverPresentationController?.backgroundColor = UIColor(red: 249.0/255, green: 211.0/255, blue: 65.0/255, alpha: 0.5)
                destination.popoverPresentationController?.delegate = self
            }
        }
    }
    
    // MARK: Handling Popover
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showPopover", sender: self.persons)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
    
}
