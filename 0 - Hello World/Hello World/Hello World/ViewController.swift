//
//  ViewController.swift
//  Hello World
//
//  Created by Jesse Tipton on 1/24/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func changeLabel() {
        print("It worked! 👍")
        
        let worldEmoji = "🌎"
        myLabel.text = "Goodbye, World! \(worldEmoji)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

}
