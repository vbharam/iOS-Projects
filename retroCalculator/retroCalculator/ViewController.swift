//
//  ViewController.swift
//  retroCalculator
//
//  Created by Vishal Bharam on 9/20/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // Outlets:
    @IBOutlet weak var outputLabel: UILabel!
    
    // Variables:
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operations: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operations.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soundPath = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: soundPath!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        // Initialize
        outputLabel.text = "0"
        
    }
    
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: Operations.Add)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOperation(operation: Operations.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: Operations.Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOperation(operation: Operations.Divide)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    
    
    func processOperation(operation: Operations){
        playSound()
        
        if currentOperation != Operations.Empty {
            
            // A user selected an operator, but selected another operator without selecting a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case Operations.Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    break
                    
                case Operations.Subtract:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    break
                    
                case Operations.Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    break
                    
                case Operations.Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    break
                    
                default:
                    result = ""
                    break
                }
                
                leftValStr = result
                outputLabel.text = result
            }
            
        } else {
            // this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
        }
        
        currentOperation = operation
    }

    
    @IBAction func clearData(sender: AnyObject){
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        outputLabel.text = "0"
        currentOperation = Operations.Empty
    }
    
    
    func playSound() {
        if (btnSound.isPlaying) {
            btnSound.stop()
        } else {
            btnSound.play()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

