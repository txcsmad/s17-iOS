//
//  GroceryItem.swift
//  Groceries
//
//  Created by Jesse Tipton on 2/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class GroceryItem: Object {
    
    dynamic var name: String = ""
    dynamic var quantity: Int = 1
    
}
