//
//  ViewController.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class ViewB: UIViewController {
    //  https://www.timeanddate.com/calendar/about-chinese.html
    
    var birthdate: Date!
    var name = "Kevin"
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    @IBAction func dateSelected(_ sender: Any) {
        birthdate = datePicker.date
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkZodiacPressed(_ sender: Any) {

        performSegue(withIdentifier: "ViewC", sender: datePicker.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewC" {
            if let destination = segue.destination as? ViewC {
                if let date = sender as? Date {
                    destination.birthdate = date
                }
            }
        }
    }
    
}

