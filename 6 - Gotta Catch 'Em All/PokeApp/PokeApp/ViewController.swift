//
//  ViewController.swift
//  PokeApp
//
//  Created by Jesse Tipton on 2/28/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var numberLabel: UILabel!
    @IBOutlet fileprivate weak var textField: UITextField!
    @IBOutlet fileprivate weak var imageView: PokeImageView!
    
    @IBAction fileprivate func search() {
        clearInterface()
        
        let query = textField.text! // (pretty much) never nil, not safe in the real world
        
        let requestURL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(query)")! // could be safer (crashes on invalid input (e.g. a space))
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: requestURL) { (data: Data?, response: URLResponse?, error: Error?) in
            // this gets called on another thread
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let id = json["id"] as! Int
            let name = json["name"] as! String
            
            let sprites = json["sprites"] as! [String: Any]
            let imageURLString = sprites["front_default"] as! String
            let imageURL = URL(string: imageURLString)!
            
            self.downloadImage(url: imageURL) { (image: UIImage) in
                // jump back onto the main thread to update UI
                DispatchQueue.main.async {
                    self.nameLabel.text = name.capitalized
                    self.numberLabel.text = "\(id)"
                    self.imageView.image = image
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func downloadImage(url: URL, completion: @escaping (UIImage) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            // this gets called on another thread
            let image = UIImage(data: data!)!
            completion(image)
        }
        dataTask.resume()
    }
    
    func clearInterface() {
        nameLabel.text = "Loading..."
        numberLabel.text = ""
        imageView.image = nil
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
