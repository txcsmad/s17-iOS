//
//  ViewController.swift
//  Text2Speech
//
//  Created by Jesse Tipton on 2/4/17.
//  Copyright © 2017 Jesse Tipton. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let synthesizer = AVSpeechSynthesizer()
    let voice = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func speak(_ sender: UIButton) {
        guard let text = textField.text else {
            return
        }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        utterance.pitchMultiplier = slider.value
        synthesizer.speak(utterance)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        synthesizer.delegate = self
//    }

}

extension ViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let speechString = utterance.speechString as NSString
        label.text = speechString.substring(with: characterRange)
    }
    
}
