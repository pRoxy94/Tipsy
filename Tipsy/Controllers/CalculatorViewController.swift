//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    var tip = 0.10
    var numberOfPeple = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
	   
	   //Dismiss the keyboard when the user chooses one of the tip values.
	   billTextField.endEditing(true)
	   
	   zeroPctButton.isSelected = false
	   tenPctButton.isSelected = false
	   twentyPctButton.isSelected = false
	   
	   // make the button that triggered the IBAction selected
	   sender.isSelected = true

	   // get the current title of the button that was pressed
	   let buttonTitle = sender.currentTitle!
	   
	   // remove the last character form the title (%)
	   let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
	   
	   // turn the string into Double
	   let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
	   
	   // e.g 10 become 0.1
	   tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
	   splitNumberLabel.text = String(format: "%.0f", sender.value)
	   numberOfPeple = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
	   let bill = billTextField.text!
	   
	   if bill != "" {
		  billTotal = Double(bill)!
		  
		  //Multiply the bill by the tip percentage and divide by the number of people to split the bill
		  let result = billTotal * (1 + tip) / Double(numberOfPeple)
		  
		  //Round the result to 2 decimal places and turn it into a String.
		  finalResult = String(format: "%.2f", result)
		  
		  //In Main.storyboard there is a segue between CalculatorVC and ResultsVC with the identifier "goToResult". This line triggers the segue to happen.
		  self.performSegue(withIdentifier: "goToResult", sender: self)
	   }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	   //If the currently triggered segue is the "goToResults" segue
	   if segue.identifier == "goToResult" {
		  //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
		  let destinationVC = segue.destination as! ResultsViewController
		  destinationVC.result = finalResult
		  destinationVC.tip = Int(tip * 100)
		  destinationVC.split = numberOfPeple
	   }
    }
}

