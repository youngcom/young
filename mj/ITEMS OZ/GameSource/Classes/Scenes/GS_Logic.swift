//
//  GS_Logic.swift
//  Math Simple
//
//  Created by Mr. Joker on 4/9/19.
//  Copyright © 2019 Mr. Joker. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func startGame() {

    }
    
    func endGame() {
        Sounds.sharedInstance().playSound(soundName: SoundConfig.soundOver)
        saveScore()
        setScore()
        makeScreenshot()
        self.changeSceneTo(scene: LevelScene(size: VisibleRect.screenSize))
    }
    
}
