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
    
    //Variable Declaration
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var totalTime = 0
    var secondsPassed = 0
    var timer  = Timer()
    var alarmSound : AVAudioPlayer?
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime{
            secondsPassed += 1

            let percentaageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentaageProgress
        }
        else{
            timer.invalidate()
            titleLabel.text = "Done"
            playSoundCoding()
        }
    }
    
    func playSoundCoding(){
        let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do{
            alarmSound = try AVAudioPlayer(contentsOf: url)
            alarmSound?.play()
        }
        catch{
            print("Can't play the sound...")
        }
    }

    
}
