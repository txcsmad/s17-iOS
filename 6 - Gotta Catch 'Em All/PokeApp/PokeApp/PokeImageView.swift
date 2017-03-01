//
//  PokeImageView.swift
//  PokeApp
//
//  Created by Jesse Tipton on 2/28/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit

class PokeImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Draw circle border
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 8
        layer.cornerRadius = frame.size.width / 2
    }

}
