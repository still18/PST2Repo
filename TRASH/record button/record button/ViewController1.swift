//
//  ViewController1.swift
//  record button
//
//  Created by Eli Ruckle on 10/18/20.
//  Copyright © 2020 Eli Ruckle. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController1: UIViewController {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Bundle.main.path(forResource: "Sound name", ofType: "m4a") != nil{
            print("Continue prossing")
        } else{
            print("Error: No File with sepcified name existed")
        }
        do {
            if let fileURL = Bundle.main.path(forResource: "recording", ofType: "m4a"){
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else{
                print("Error: No File with sepcified name existed")
            }
        } catch let error {
            print("Can't play the audio file, failed with an error \(error.localizedDescription)")
        }
        audioPlayer?.numberOfLoops = 0
        audioPlayer?.play()
    }
    @IBAction func stopbutton(_ sender: Any) {
        audioPlayer?.stop()
    }
    



}

//this file is the playback file, i am following this tutorial...i am trying to set it up right now to test the audio recorder but I'm getting stuck on figuring out how to link the storyboard.storyboard to the main page... and then i have to chang the class of the 2nd storyboard on that page to view controller...if we ge this working we should be able to use it for song playback as well

// video... https://www.youtube.com/watch?v=6oa20bjes1w

