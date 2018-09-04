//
//  MeaningsViewController.swift
//  Kashur
//
//  Created by Abdul Basit on 31/08/18.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import UIKit
import AVFoundation

class MeaningsViewController: UIViewController {
@IBOutlet weak var meaningsText: UITextView!
    
    @IBOutlet weak var speakerButton: UIButton!
    var meaningText :String = String()
    var word = String()
    var audioPath = String()
    var sound : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meaningsText.text = meaningText
        word = word.replacingOccurrences(of: " ", with: "%20")
        
        if  let path = Bundle.main.path(forResource:"audios/"+word,ofType:".wav"){
            audioPath = path
            speakerButton.isHidden = false
            let url = URL(fileURLWithPath: audioPath)

            do{
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                sound = try AVAudioPlayer(contentsOf: url)
                sound?.prepareToPlay()
            }
            catch{
                print("something bad happened")
            }
        }
        else{
            speakerButton.isHidden = true
        }
    }

    @IBAction func speakerButtonClicked(_ sender: Any) {
        sound?.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
