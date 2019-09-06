//
//  MenuScene.swift
//  GameSource
//
//  Created by Mr. Joker on 4/8/19.
//  Copyright © 2019 Mr. Joker. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene : Scene  {
    let logo = Label(text: "牧场连连看", fontSize: 35, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.withPercent(50, y: 85), zPosition: GameConfig.zPosition.layer_2)
    
    let startBtn = Button(normalName: "playBtn", size: CGSize.withPercent(35, height: 8), position: CGPoint.withPercent(50, y: 60), zPosition: GameConfig.zPosition.layer_3)
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
         self.makeScreenshot()
        bestLbl.text = "最高分: \(UserDefaults.standard.integer(forKey: GameConfig.bestScore))"
        GameViewHelper.alignItemsVerticallyWithPadding(padding: 35, items: [startBtn, rankingBtn, rateBtn, shareBtn], position: CGPoint.withPercent(50, y: 50))
        addChild([backgroundSpr, rankingBtn, soundBtn, shareBtn, startBtn, logo, bestLbl, rateBtn])
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
            
            if startBtn.contains(location) {
                changeSceneTo(scene: LevelScene(size: VisibleRect.screenSize))
            }
            
            if shareBtn.contains(location) {
                self.share()
            }
            
            if rateBtn.contains(location) {
                self.rateUs()
            }
        }
        
        touchUpAllButtons()
    }
}
