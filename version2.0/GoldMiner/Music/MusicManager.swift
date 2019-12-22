//
//  MusicManager.swift
//  GoldMiner
//
//  Created by apple on 2019/12/19.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import Foundation
//import SpriteKit
import AVFoundation

class MusicManager {
    var bgmPlayer: AVAudioPlayer = {
            var player:AVAudioPlayer?
            let mp3Path = Bundle.main.path(forResource: "level-bg", ofType: "mp3")
            let pathURL = NSURL.fileURL(withPath: mp3Path!)
            do {
                try player = AVAudioPlayer(contentsOf: pathURL)
            } catch {
                print(error)
            }
            return player!
        }()
    var passPlayer: AVAudioPlayer = {
        var player:AVAudioPlayer?
        let mp3Path = Bundle.main.path(forResource: "LevelPass", ofType: "mp3")
        let pathURL = NSURL.fileURL(withPath: mp3Path!)
        do {
            try player = AVAudioPlayer(contentsOf: pathURL)
        } catch {
            print(error)
        }
        return player!
    }()
    var menuPlayer: AVAudioPlayer = {
        var player:AVAudioPlayer?
        let mp3Path = Bundle.main.path(forResource: "menu-bg", ofType: "mp3")
        let pathURL = NSURL.fileURL(withPath: mp3Path!)
        do {
            try player = AVAudioPlayer(contentsOf: pathURL)
        } catch {
            print(error)
        }
        return player!
    }()
    var cutPlayer: AVAudioPlayer = {
        var player:AVAudioPlayer?
        let mp3Path = Bundle.main.path(forResource: "PreStart", ofType: "mp3")
        let pathURL = NSURL.fileURL(withPath: mp3Path!)
        do {
            try player = AVAudioPlayer(contentsOf: pathURL)
        } catch {
            print(error)
        }
        return player!
    }()
    
    init() {
        // 循环播放
        bgmPlayer.numberOfLoops = -1
        
        
        
        
        menuPlayer.numberOfLoops = -1
        
        
        
    }
    
    func playBGM() {
        bgmPlayer.prepareToPlay()
        bgmPlayer.play()
    }
    
    func stopBGM() {
        bgmPlayer.stop()
        bgmPlayer.updateMeters()
    }
    
    func playPass() {
        passPlayer.prepareToPlay()
        passPlayer.play()
    }
    
    func stopPass() {
        passPlayer.stop()
    }
    
    func playMenu() {
        menuPlayer.prepareToPlay()
        menuPlayer.play()
    }
    
    func stopMenu() {
        menuPlayer.stop()
        menuPlayer.updateMeters()
    }
    
    func playCut() {
        cutPlayer.prepareToPlay()
        cutPlayer.play()
    }
    
    func stopCut() {
        cutPlayer.stop()
    }
}
