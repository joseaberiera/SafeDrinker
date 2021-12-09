//
//  IntroScreenViewController.swift
//  DrinkCounter
//
//  Created by Jose Riera on 12/6/21.
//

import UIKit
import AVFoundation

class IntroScreenViewController: UIViewController {
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var appNameTextLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound(name: "canOpen")
        
        drinkImageView.alpha = 0.0
        appNameTextLabel.alpha = 0.0
        
        UIView.animate(withDuration: 2.0, delay: 0.0, animations: {self.drinkImageView.alpha = 1.0; self.appNameTextLabel.alpha = 1.0})

    }
    
    func playSound(name: String){
        if let sound = NSDataAsset(name: name){
            do{
                audioPlayer = try AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            }catch{
                print("ERROR: Data in \(name) could not be played as a sound.")
            }
        }else{
            print("ERROR: Could not read data from file name: \(name)")
        }
        
    }
    
    @IBAction func drinkImageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowBACCalculator", sender: sender)
    }
    
}
