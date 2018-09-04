//
//  ViewController.swift
//  Kashur
//
//  Created by Abdul Basit on 03/09/18.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var jsonData : Dictionary<String,AnyObject>?
    var words = [String]()
    var audioPath = String()
    var sound : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromJSON()
        words = (jsonData! as NSDictionary).allKeys as! [String]
        self.navigationItem.title = "Kashur"
        words.sort()
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next:MeaningsViewController = storyboard?.instantiateViewController(withIdentifier: "meaningController") as! MeaningsViewController
        next.meaningText = (jsonData?[words[indexPath.row]] as? String)!
        next.navigationItem.title = words[indexPath.row]
        next.word = words[indexPath.row]
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordscell", for: indexPath) as! MainTableViewCell
        cell.wordsLabel.text = words[indexPath.row]
        if !getAudio(indexPath.row){
            cell.speakerButton.isHidden = false
            cell.speakerButton.tag = indexPath.row
            cell.speakerButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        }
        else{
            cell.speakerButton.isHidden = true
        }
        return cell
    }
    
    @objc func buttonClicked(sender: UIButton) {
        getAudio(sender.tag)
        sound?.play()
    }
    
    
    func getAudio(_ index:Int) -> Bool{
        if  let path = Bundle.main.path(forResource:"audios/"+words[index],ofType:".wav"){
            audioPath = path
            let url = URL(fileURLWithPath: audioPath)
            
            do{
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                sound = try AVAudioPlayer(contentsOf: url)
                sound?.prepareToPlay()
            }
            catch{
                print("something bad happened")
                return true
            }
            return false
        }
        else{
            return true
        }
    }
    
    
    func getDataFromJSON(){
        //Code for getting the quotes from the json file......
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>{
                    jsonData = jsonResult
                    
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
}

