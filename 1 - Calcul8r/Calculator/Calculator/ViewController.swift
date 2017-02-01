//
//  ViewController.swift
//  Calculator
//
//  Created by Jesse Tipton on 1/31/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var leftHandSide: Double = 0
    var selectedOperator: String = ""
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        let stringNumber = sender.titleLabel!.text!
        if displayLabel.text == "0" {
            displayLabel.text = stringNumber
        } else {
            displayLabel.text! += stringNumber
        }
    }
    
    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        leftHandSide = Double(displayLabel.text!)!
        selectedOperator = sender.titleLabel!.text!
        displayLabel.text = "0"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let rightHandSide = Double(displayLabel.text!)!
        var solution: Double = 0
        switch selectedOperator {
        case "÷":
            solution = leftHandSide / rightHandSide
        case "✕":
            solution = leftHandSide * rightHandSide
        case "-":
            solution = leftHandSide - rightHandSide
        case "+":
            solution = leftHandSide + rightHandSide
        default:
            fatalError("Oh boy...")
        }
        displayLabel.text = "\(solution)"
    }
    
    @IBAction func clearPressed() {
        leftHandSide = 0
        selectedOperator = ""
        displayLabel.text = "0"
    }
    
}

