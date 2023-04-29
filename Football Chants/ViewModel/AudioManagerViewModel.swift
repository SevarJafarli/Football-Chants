//
//  AudioManagerViewModel.swift
//  Football Chants
//
//  Created by Sevar Jafarli on 28.04.23.
//

import Foundation
import AVKit

class AudioManagerViewModel {
    private var chantAudioPlayer: AVAudioPlayer?
    
    func playback(_ team: Team) {
        if team.isPlaying {
            chantAudioPlayer?.stop()
        }
        else{
            guard let url = Bundle.main.url(forResource: team.id.chantFile, withExtension: "mp3") else {return}
            
            do {
                chantAudioPlayer = try AVAudioPlayer(contentsOf: url)
                
                // Set numberOfLoops to -1 to play the audio file indefinitely
                chantAudioPlayer?.numberOfLoops = -1
                
                chantAudioPlayer?.play()
                
            }
            catch {
                print(error)
            }
        }
    }
}
