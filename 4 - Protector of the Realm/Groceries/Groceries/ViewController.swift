//
//  ViewController.swift
//  Groceries
//
//  Created by Jesse Tipton on 2/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var groceryItems: Results<GroceryItem> {
        return realm.objects(GroceryItem.self)
    }
    
//    func groceryItems() -> Results<GroceryItem> {
//        return realm.objects(GroceryItem.self)
//    }
    
    @IBAction func addGroceryItem() {
        let addAlertController = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        
        addAlertController.addTextField(configurationHandler: nil)
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action: UIAlertAction) -> Void in
            // what happens when the button gets pressed
            
            // getting the text from the text field
            let textFields = addAlertController.textFields!
            let firstTextField = textFields[0]
            let name = firstTextField.text!

            // creating our new item
            let newGroceryItem = GroceryItem()
            newGroceryItem.name = name
            
            // adding the item to realm
            let realm = try! Realm()
            try! realm.write {
                realm.add(newGroceryItem)
            }
            
            // update the table view
            self.tableView.reloadData()
        })
        addAlertController.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        addAlertController.addAction(cancelAction)
        
        self.present(addAlertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditGroceryItemViewController {
            if let index = tableView.indexPathForSelectedRow {
                destination.groceryItem = groceryItems[index.row]
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // delete the grocery item
            let groceryItem = groceryItems[indexPath.row]
            try! realm.write {
                realm.delete(groceryItem)
            }
            
            // tell the table view it's gone
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
