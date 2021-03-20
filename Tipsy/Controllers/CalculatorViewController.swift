//
//  ViewController.swift
//  Tipsy
//
//  Created by Igor Lishchenko on 02.12.2020.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip: Double = 0.0
    var numberOfPeople: Double = 2
    var billTotal = ""
    
    func amountForPerson() -> String {
        let amount = (Double(billTotal)! * tip + Double(billTotal)!) / numberOfPeople
        return String(format: "%.2f", amount)
    }
    
    @IBAction func tipCganged(_ sender: UIButton) {
        //Deselect all tip buttons via IBOutlets
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        
        //Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        //Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        //Divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
        tip = buttonTitleAsANumber / 100
        
        billTotal = billTextField.text!
        
        billTextField.endEditing(true)
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //Get the stepper value using sender.value, round it down to a whole number then set it as the text in
        //the splitNumberLabel
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        //Set the numberOfPeople property as the value of the stepper as a whole number.
        numberOfPeople = Double(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        print(tip)
        print(numberOfPeople)
        print(billTotal)
        print(amountForPerson())
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goToResults"{
            let resultsVC = segue.destination as! ResultsViewController
            resultsVC.totalLabelText = amountForPerson()
            resultsVC.settingsLabelText = "Split between \(Int(numberOfPeople)) people, with 10% tip."
            
        }
        
    }
    
}



