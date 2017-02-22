//
//  EditGroceryItemViewController.swift
//  Groceries
//
//  Created by Jesse Tipton on 2/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class EditGroceryItemViewController: UIViewController {

    var groceryItem: GroceryItem!
    
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
        quantityLabel.text = "Quantity: \(Int(sender.value))"
    }
    
    @IBAction func save(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            if let text = nameTextField.text, text != "" {
                groceryItem.name = text
            }
            groceryItem.quantity = Int(quantityStepper.value)
        }
    }
    
    
}
