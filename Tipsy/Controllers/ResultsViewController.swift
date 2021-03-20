//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Igor Lishchenko on 02.12.2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit



class ResultsViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalLabelText = ""
    var settingsLabelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalLabel.text = totalLabelText
        settingsLabel.text = settingsLabelText
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    

}
