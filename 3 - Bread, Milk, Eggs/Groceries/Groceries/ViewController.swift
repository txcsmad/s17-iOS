//
//  ViewController.swift
//  Groceries
//
//  Created by Jesse Tipton on 2/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var groceryItems = [
        GroceryItem(name: "Bread", quantity: 1),
        GroceryItem(name: "Milk", quantity: 1),
        GroceryItem(name: "Eggs", quantity: 12)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditGroceryItemViewController {
            if let index = tableView.indexPathForSelectedRow {
                destination.groceryItem = groceryItems[index.row]
                destination.delegate = self
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let groceryItem = groceryItems[indexPath.row]
        
        cell.textLabel?.text = groceryItem.name
        cell.detailTextLabel?.text = "\(groceryItem.quantity)"
        
        return cell
    }
    
}


extension ViewController: EditGroceryItemViewControllerDelegate {
    func save(groceryItem: GroceryItem) {
        if let index = tableView.indexPathForSelectedRow {
            groceryItems[index.row] = groceryItem
            tableView.reloadData()
        }
    }
}


