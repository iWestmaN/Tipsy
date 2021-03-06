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
    var billTotal = 0.0
    var finalResult = "0.0"
  
    func amountForPerson() -> String {
        let amount = (Double(billTotal) * tip + Double(billTotal)) / numberOfPeople
        return String(format: "%.2f", amount)
    }
    
    @IBAction func tipCganged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        //Deselect all tip buttons via IBOutlets
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        guard let buttonTitle = sender.currentTitle else { return }
        
        //Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        //Turn the String into a Double.
        let buttonTitleAsANumber = buttonTitleMinusPercentSign.doubleValue
        
        //Divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
        tip = buttonTitleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //Get the stepper value using sender.value, round it down to a whole number then set it as the text in
        //the splitNumberLabel
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        //Set the numberOfPeople property as the value of the stepper as a whole number.
        numberOfPeople = Double(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        guard let bill = billTextField.text else { return }
        if bill != ""  {
            if zeroPctButton.isSelected || tenPctButton.isSelected || twentyPctButton.isSelected {
                billTotal = bill.doubleValue
                let result = billTotal * (1 + tip) / Double(numberOfPeople)
                finalResult = String(format: "%.2f", result)
                self.performSegue(withIdentifier: "goToResults", sender: self)
            } else {
                let alert = UIAlertController(title: "Choose tips %", message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            let alert = UIAlertController(title: "Enter bill total", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goToResults" {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = Int(numberOfPeople)
        }
        
    }
    
}

extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}



