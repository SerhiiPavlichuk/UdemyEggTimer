//
//  ViewController.swift
//  UdemyEggTimer
//
//  Created by admin on 28.03.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime: Float = 0
    var secondsPassed: Float = 0
    var player = AVAudioPlayer()

    @IBAction func eggHardnessButtonPressed(_ sender: UIButton) {

        timer.invalidate()
        progressBar.progress = 0.0

        guard let hardness = sender.currentTitle else { return }
        titleLabel.text = hardness
        if let unwrapedSeconds = eggTimes[hardness] {
            totalTime = Float(unwrapedSeconds)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }

    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = secondsPassed / totalTime
            progressBar.progress = percentageProgress
            print(percentageProgress)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound(soundName: "alarm_sound")
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()

    }
}


