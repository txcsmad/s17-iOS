//
//  EditGroceryItemViewController.swift
//  Groceries
//
//  Created by Jesse Tipton on 2/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit

protocol EditGroceryItemViewControllerDelegate: class {
    func save(groceryItem: GroceryItem)
}

class EditGroceryItemViewController: UIViewController {

    var groceryItem: GroceryItem!
    
    weak var delegate: EditGroceryItemViewControllerDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = groceryItem.name
        quantityLabel.text = "Quantity: \(groceryItem.quantity)"
        quantityStepper.value = Double(groceryItem.quantity)
    }
    
    @IBAction func toggleStepper(_ sender: UIStepper) {
        groceryItem.quantity = Int(sender.value)
        quantityLabel.text = "Quantity: \(groceryItem.quantity)"
    }
    
    @IBAction func save(_ sender: Any) {
        if let text = nameTextField.text, text != "" {
            groceryItem.name = text
        }
        
        delegate?.save(groceryItem: groceryItem)
    }
    
    
}
