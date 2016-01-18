//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Bock on 1/17/16.
//  Copyright © 2016 Michael R. Bock. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!

    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func playAtRate(rate: Float) {
        audioEngine.stop()
        audioEngine.reset()

        audioPlayer.stop()

        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        
        audioEngine.stop()
        audioEngine.reset()

        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)

        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()

        audioPlayerNode.play()
    }

    @IBAction func playSlowRecording(sender: UIButton) {
        playAtRate(0.5)
    }

    @IBAction func playFastRecording(sender: UIButton) {
        playAtRate(2.0)
    }

    @IBAction func playChipmunkRecording(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

    @IBAction func playVaderRecording(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    @IBAction func stopPlaying(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.stop()
    }
}
