//
//  EndScene.swift
//  GameSource
//
//  Created by Mr. Joker on 4/9/19.
//  Copyright © 2019 Mr. Joker. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene : Scene  {

    override func didMove(to view: SKView) {

        addChild([backgroundSpr, rankingBtn, soundBtn, scoreLbl, bestLbl])

        setScore()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            //Check press to switch
            soundBtn.changeSwitchState(ifInLocation: location)
            
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
           if rankingBtn.contains(location) {
                self.showLeaderboard()
            }
        }
        
        touchUpAllButtons()
    }
}
