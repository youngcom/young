//
//  GameScene.swift
//  GameSource
//
//  Created by Mr. Joker on 3/21/19.
//  Copyright © 2019 Mr. Joker. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: Scene {
     var timerEnd = Timer()
    var timer = 100
    var circles = [Circle]()
    var questionType: Int = 1
    var count: Int = 0
    var maxTypes = [Int]()
    
    let board = Sprite(imageNamed: "board", size: CGSize.withPercent(40, height: 15), position: CGPoint.withPercent(55, y: 70), zPosition: GameConfig.zPosition.layer_2)
    let scoreBoard = Sprite(imageNamed: "score", size: CGSize.withPercentScaled(roundByWidth: 10), position: CGPoint.withPercent(80, y: 23), zPosition: GameConfig.zPosition.layer_4)
    let timeBoard = Sprite(imageNamed: "clock", size: CGSize.withPercentScaled(roundByWidth: 10), position: CGPoint.withPercent(76, y: 90), zPosition: GameConfig.zPosition.layer_4)
    let timeLbl = Label(text: "0", fontSize: 30, fontName: GameConfig.fontNumber, color: UIColor.red, position: CGPoint.withPercent(86, y: 90), zPosition: GameConfig.zPosition.layer_5)
    let infoBar = Sprite(imageNamed: "infoBar", size: CGSize.withPercent(80, height: 10), position: CGPoint.withPercent(50, y: 13), zPosition: GameConfig.zPosition.layer_3)
    let type1Btn = Button(normalName: "1", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(20, y: 13), zPosition: GameConfig.zPosition.layer_4)
    let type2Btn = Button(normalName: "2", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(40, y: 13), zPosition: GameConfig.zPosition.layer_4)
    let type3Btn = Button(normalName: "3", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(60, y: 13), zPosition: GameConfig.zPosition.layer_4)
    let type4Btn = Button(normalName: "4", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(80, y: 13), zPosition: GameConfig.zPosition.layer_4)
    let lvLabel = Label(text: "Level: 1", fontSize: 30, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.withPercent(50, y: 90), zPosition: GameConfig.zPosition.layer_3)
    
    let question = Label(text: "选择上面出现较多的动物", fontSize: 18, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.withPercent(36, y: 23), zPosition: GameConfig.zPosition.layer_4)
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let level = UserDefaults.standard.integer(forKey: "level")
        lvLabel.text = "Level: "+String(level)
        
        if level < 8 {
            timer = 60 - level
        }
        
        if level >= 8 && level <= 15 {
            timer = 50 - level
        }
        
        setInterface()
        createBoard()
        updateTimer()
        startGame()
    }
    
    func setInterface() {
        scoreLbl.position = CGPoint.withPercent(92, y: 23)
        addChild([backgroundSpr, scoreLbl, timeLbl, backBtn, timeBoard, scoreBoard, type1Btn, type2Btn, type3Btn, type4Btn, infoBar, lvLabel, question])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if backBtn.contains(location) {
                changeSceneTo(scene: LevelScene(size: VisibleRect.screenSize))
            }
            soundBtn.changeSwitchState(ifInLocation: location)
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if type1Btn.contains(location) {
                if maxTypes.contains(1) {
                    increaseScoreBy(1)
                    resetGameBoard()
                } else {
                    increaseScoreBy(-1)
                    Sounds.sharedInstance().playSound(soundName: SoundConfig.soundFail)
                }
            }
            
            if type2Btn.contains(location) {
                if maxTypes.contains(2) {
                    increaseScoreBy(1)
                    resetGameBoard()
                } else {
                    increaseScoreBy(-1)
                    Sounds.sharedInstance().playSound(soundName: SoundConfig.soundFail)
                }
            }
            
            if type3Btn.contains(location) {
                if maxTypes.contains(3) {
                    increaseScoreBy(1)
                    resetGameBoard()
                } else {
                    increaseScoreBy(-1)
                    Sounds.sharedInstance().playSound(soundName: SoundConfig.soundFail)
                }
            }
            
            if type4Btn.contains(location) {
                if maxTypes.contains(4) {
                    increaseScoreBy(1)
                    resetGameBoard()
                } else {
                    increaseScoreBy(-1)
                    Sounds.sharedInstance().playSound(soundName: SoundConfig.soundFail)
                }
            }
        }
        
        touchUpAllButtons()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    @objc func updateTimer() {
        callTimer()
        timerEnd = Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(self.callTimer), userInfo: nil, repeats: true)
    }
    @objc func callTimer() {
        timer -= 1
        timeLbl.text = String(timer)
        
        if timer <= 0 {
            timerEnd.invalidate()
            endGame()
        }
    }
    
    
    func resetGameBoard() {
        for circle in circles {
            circle.removeFromParent()
        }
        circles.removeAll()
        maxTypes.removeAll()
        createBoard()
    }
}
