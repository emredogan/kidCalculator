//
//  Helper.swift
//  KidCalc
//
//  Created by Emre Dogan on 03/04/2022.
//

import Foundation
import AVFoundation
import SCLAlertView


struct Helper {
    var audioPlayer: AVAudioPlayer!
    static let preferences = UserDefaults.standard
    
    init() {
        guard let audioData = NSDataAsset(name: "button_sound")?.data else {
           fatalError("Unable to find asset")
        }

        do {
            self.audioPlayer = try AVAudioPlayer(data: audioData)
            self.audioPlayer.prepareToPlay()
        } catch {
           fatalError(error.localizedDescription)
      }
    }
    
    
    
    
    static func readFromPreferences(key: String) -> Bool?{
        let currentLevelKey = key

        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            return nil
        } else {
            let hasSeenTheInfo = preferences.bool(forKey: key)
            return hasSeenTheInfo
        }
    }
    
    static func writeToPreferences(key: String, value: Bool) {
        preferences.set(value, forKey: key)
        preferences.synchronize()
    }

    
    mutating func playAudioAsset(_ assetName : String) {
          guard let audioData = NSDataAsset(name: assetName)?.data else {
             fatalError("Unable to find asset \(assetName)")
          }

          do {
              self.audioPlayer = try AVAudioPlayer(data: audioData)
              self.audioPlayer.play()
          } catch {
             fatalError(error.localizedDescription)
        }
    }
    
    func customAlert(header: String, subtitle: String) {
        SCLAlertView().showError(header, subTitle: subtitle) // Error
    }
    
    func customInfo (header: String, subtitle: String) {
        SCLAlertView().showInfo(header, subTitle: subtitle)
    }
}
