//
//  ViewController.swift
//  spacecalc
//
//  Created by Ross Russell on 1/13/16.
//  Copyright © 2016 com.orangemelt. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var outputLbl: UILabel!
  
  enum Operation: String {
    case Divide = "/"
    case Multiply = "*"
    case Subtract = "-"
    case Add = "+"
    case Empty = "Empty"
  }
  
  //Don't worry! You will have things.
  
  
  var btnSound: AVAudioPlayer!
  
  var runningNum = ""
  var leftValStr = ""
  var rightValStr = ""
  var currentOperation: Operation = Operation.Empty
  var result = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    outputLbl.text="0"
    //Grab the path of the sound file.
    let path = NSBundle.mainBundle().pathForResource( "BEEP1C", ofType: "WAV" )
    //Apparently the audio player wants this to be in NSURL form.
    let soundURL = NSURL(fileURLWithPath: path!)
    //make sure that we try.
    do{
      try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
      btnSound.prepareToPlay()
    } catch let err as NSError{
      print( err.debugDescription )
    }
  }
  
  
  @IBAction func numberPressed( btn: UIButton! ){
    playSound()
    runningNum += "\(btn.tag)"
    outputLbl.text = runningNum
    
  }
  
  @IBAction func plusPressed( btn: UIButton ){
    processOperation(Operation.Add)
  }
  
  @IBAction func divPressed( btn: UIButton ){
    processOperation(Operation.Divide)
  }
  
  @IBAction func minusPressed( btn: UIButton ){
    processOperation(Operation.Subtract)
  }
  
  @IBAction func multPressed( btn: UIButton ){
    processOperation(Operation.Multiply)
  }
  
  @IBAction func equalPressed( btn: UIButton){
    processOperation(currentOperation)
  }
  
  func processOperation( op: Operation ){
    playSound()
    
    if currentOperation != Operation.Empty{
      if runningNum != "" {
        rightValStr = runningNum
        runningNum = ""
        
        if currentOperation == Operation.Multiply{
          result = "\(Double(leftValStr)! * Double(rightValStr)! )"
        }else if currentOperation == Operation.Divide{
          result = "\(Double(leftValStr)! / Double( rightValStr)!)"
        }else if currentOperation == Operation.Subtract{
          result = "\(Double(leftValStr)! - Double(rightValStr)!)"
        }else if currentOperation == Operation.Add{
          result = "\(Double(leftValStr)! + Double( rightValStr)!)"
        }
        
        leftValStr = result
        outputLbl.text = result
      
      }
      
      
      currentOperation = op
    } else {
      //first operator press
      leftValStr = runningNum
      runningNum = ""
      currentOperation = op
    }
    
  }
  
  
  func playSound(){
    if btnSound.playing {
       btnSound.stop()
    }
    btnSound.play()
  }
}

