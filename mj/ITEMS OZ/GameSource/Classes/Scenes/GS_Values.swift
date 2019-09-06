//
//  GS_Values.swift
//  Math Basic
//
//  Created by Mr. Joker on 4/17/19.
//  Copyright © 2019 Mr. Joker. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    //MARK: - Score
    
    func increaseScoreBy(_ value: Int) {
        score += value
        score <= 0 ? (score = 0) : ()
        scoreLbl.changeTextWithAnimationScaled(withText: score)
        
        Sounds.sharedInstance().playSound(soundName: SoundConfig.soundScore)
    }
    
    func saveScore() {
        UserDefaults.standard.set(score, forKey: GameConfig.currentScore)
        if score > UserDefaults.standard.integer(forKey: GameConfig.bestScore) {
            UserDefaults.standard.set(score, forKey: GameConfig.bestScore)
        }
        
        self.submitScore()
    }

    //MARK: Gameplay
    
}
