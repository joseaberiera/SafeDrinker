//
//  ViewController.swift
//  DrinkCounter
//
//  Created by Jose Riera on 12/6/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var phraseTextLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var BACLabel: UILabel!
    @IBOutlet weak var drinkCounterLabel: UILabel!
    @IBOutlet weak var addDrinkButton: UIButton!
    
    
    let phrases = ["👍You are doing great!👍", "💧Maybe you should mix in a water💧", "🛑You should stop drinking for the night🛑", "🏠Its time to go home🏠", "🚨CALL AN AMBULANCE!!!🚨"]
    let male = 0.68
    let female = 0.55
    let gramsOfAlcPerDrink = 14.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BACLabel.text = "0.0"
        drinkCounterLabel.text = "0"
        faceImageView.image = nil
        phraseTextLabel.text = "Please enter your weight and gender in the boxes below"
        
        addDoneButtonOnNumpad(textField: weightTextField)
        
    }

    func addDoneButtonOnNumpad(textField: UITextField) {
            
            let keypadToolbar: UIToolbar = UIToolbar()
            
            // add a done button to the numberpad
            keypadToolbar.items=[
                UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
                UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
            ]
            keypadToolbar.sizeToFit()
            // add a toolbar with a done button above the number pad
            textField.inputAccessoryView = keypadToolbar
        }//addDoneToKeyPad

    func weightInGrams(weight: String) -> Double{
        if let weight = Double(weight) {
            let weightInGrams = weight * 453.592
            return weightInGrams
        }
        return 0.0
    }
    
    func gender(gender: String) -> Double{
        let gender = gender
        var constant = 0.0
        if gender == "MALE" || gender == "M"{
            constant = male
        }else{
            constant = female
        }
        return constant
    }
    
    func calculateBAC() -> Double{
        var bac = 0.0
        let weight = weightInGrams(weight: weightTextField.text!)
        let constant = gender(gender: genderTextField.text!)
        guard let drinksHad = Double(drinkCounterLabel.text!) else { return 0.0 }
        bac = ((gramsOfAlcPerDrink * drinksHad)/(weight * constant))*100
        return round(bac*1000)/1000.0
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        genderTextField.resignFirstResponder()
    }
    
    @IBAction func addDrinkButtonPressed(_ sender: UIButton) {
        if weightTextField.text == "" || genderTextField.text == ""{
            return
        }
        var counter = Int(drinkCounterLabel.text!) ?? 0
        counter += 1
        drinkCounterLabel.text = "\(counter)"
        
        BACLabel.text = String(calculateBAC())
        
        let bac = calculateBAC()
        
        switch bac {
        case 0.0...0.099:
            faceImageView.image = UIImage(named: "smiley")
        case 0.100...0.159:
            faceImageView.image = UIImage(named: "medium")
        default:
            faceImageView.image = UIImage(named: "frowny")
        }
        
        switch bac {
        case 0.0...0.059:
            phraseTextLabel.text = phrases[0]
        case 0.060...0.129:
            phraseTextLabel.text = phrases[1]
        case 0.130...0.159:
            phraseTextLabel.text = phrases[2]
        case 0.160...0.249:
            phraseTextLabel.text = phrases[3]
        default:
            phraseTextLabel.text = phrases[4]
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        var counter = Int(drinkCounterLabel.text!) ?? 0
        counter = 0
        drinkCounterLabel.text = "\(counter)"
        
        //reset BACLabel
        var bacLevel = Double(BACLabel.text!) ?? 0
        bacLevel = 0.0
        BACLabel.text = "\(bacLevel)"
        
        //reset faceImageView
        faceImageView.image = nil
        
        //reset phraseLabel
        phraseTextLabel.text = "Please enter your weight and gender in the boxes below"
        
        //reset weightTextField
        weightTextField.text! = ""
        
        //reset genderTextField
        genderTextField.text! = ""
    }
    
}

