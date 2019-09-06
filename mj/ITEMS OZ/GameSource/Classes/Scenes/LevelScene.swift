//
//  ModeScene.swift
//  GG
//
//  Created by Duy on 6/16/19.
//  Copyright © 2019 Cao Nguyen Duy. All rights reserved.
//

import Foundation
import SpriteKit

class LevelScene: Scene {
    var levels = [Level]()
    var bestScore: Int = 0
    let logo = Label(text: "牧场连连看", fontSize: 35, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.withPercent(50, y: 85), zPosition: GameConfig.zPosition.layer_2)
    
    let lv1 = Button(normalName: "1", size: CGSize.withPercent(75, height: 15), position: CGPoint.withPercent(50, y: 60), zPosition: GameConfig.zPosition.layer_3)
    let mode2 = Button(normalName: "mode2", size: CGSize.withPercent(75, height: 15), position: CGPoint.withPercent(50, y: 40), zPosition: GameConfig.zPosition.layer_3)
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        bestScore = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        bestLbl.text = "最高分: \(bestScore)"
        bestLbl.position = CGPoint.withPercent(50, y: 13)
        createLevelButton()
        backgroundSpr.texture = SKTexture(imageNamed: "Images/lvScene")
        addChild([backgroundSpr, backBtn, bestLbl])
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
            for level in levels {
                if level.contains(location) && level.type == 2 {
                    var lvlNumber = Int(levels.index(of: level)!)
                    lvlNumber += 1
                    UserDefaults.standard.set(lvlNumber, forKey: "level")
                    changeSceneTo(scene: GameScene(size: VisibleRect.screenSize))
                }
                if level.contains(location) && level.type == 1 {
                    Sounds.sharedInstance().playSound(soundName: SoundConfig.soundFail)
                }
            }
            
            if backBtn.contains(location) {
                changeSceneTo(scene: MenuScene(size: VisibleRect.screenSize))
            }
        }
        
        touchUpAllButtons()
    }
    
    func createLevelButton() {
        let cols = 4
        let rows = 5
        
        let xScale:CGFloat = CGFloat(0.65*VisibleRect.screenSize.width/CGFloat(cols))
        let yScale:CGFloat = CGFloat(0.65*VisibleRect.screenSize.height/CGFloat(rows))
        let sizeOfCell = (xScale < yScale) ? (xScale) : (yScale)
        for level in 1...20 {
            if bestScore >= level * 4 {
                UserDefaults.standard.set(level, forKey: "unlock")
            }
            let currentLvl = UserDefaults.standard.integer(forKey: "unlock")
            let btnLevel = Level()
            btnLevel.label.text = String(level)
            if level <= currentLvl || level == 1 {
                btnLevel.type = 2
                btnLevel.texture = SKTexture(imageNamed: "Images/level")
            } else {
                btnLevel.label.color = UIColor.black
                btnLevel.texture = SKTexture(imageNamed: "Images/lock")
            }
            
            btnLevel.size = CGSize(width: sizeOfCell, height: sizeOfCell)
            levels.append(btnLevel)
            addChild(btnLevel)
        }
        
        GameViewHelper.alignItemsRowsAndCols(padding: 25, rows: 5, cols: 4, items: levels, position: CGPoint.withPercent(50, y: 50))
    }
}
