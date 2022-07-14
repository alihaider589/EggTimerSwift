//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player : AVAudioPlayer?
    let eggTimings:[String:Int]  = ["Soft":3,"Medium":4, "Hard":7]
   
    var eggStatus = ""
    var secondPassed:Float = 0
    var totalTime:Float = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()

        let hardness = sender.currentTitle ?? ""
        progressBar.progress = 0.0
        secondPassed = 0
        totalTime = Float(eggTimings[hardness] ?? 0)
      
        titleLabel.text = "Boiling your egg..."
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        
    }
  

    @objc func updateTimer (){
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progressTintColor = UIColor.yellow
            let percentageProgress = secondPassed / totalTime
            progressBar.setProgress(Float(percentageProgress), animated:true)
            
            print(percentageProgress)
          
         
            
        }else{
            timer.invalidate()
            titleLabel.text = "Done"
            playSound(soundName: "alarm_sound", soundType: "mp3")
            progressBar.progressTintColor = UIColor.green
        }

    }
    

    func playSound(soundName:String,soundType:String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }
        
        

        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint:AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    
    }
}

