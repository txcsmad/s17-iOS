//
//  MapItemTableViewCell.swift
//  MapApp
//
//  Created by Jesse Tipton on 3/28/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit

class MapItemTableViewCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = ""
        detailTextLabel?.text = ""
        accessoryType = .none
    }
    
}
