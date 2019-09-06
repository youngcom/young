//
//  BaseScene.swift
//  GameSource
//
//  Created by Cao Nguyen Duy on 3/21/19.
//  Copyright © 2019 Cao Nguyen Duy. All rights reserved.
//

import SpriteKit

class Scene : SKScene, ToggleButtonDelegate {
    
    var score:Int = 0
    var best:Int = 0
    var generateBGObjectsNow = true
    
    var buttons = [Button]()
    
    let backgroundSpr = Sprite.init(imageNamed: "background", size: CGSize.withPercent(100, height: 100), position: VisibleRect.center(), zPosition: GameConfig.zPosition.layer_1)
    
    let soundBtn = ToggleButton(imageOn: "img_sound_on", imageOff: "img_sound_off", size: CGSize.withPercentScaled(roundByWidth: 16), position: CGPoint.withPercent(92, y: 10), zPosition: GameConfig.zPosition.layer_3)
    
    let rankingBtn = Button(normalName: "rankBtn", size: CGSize.withPercent(35, height: 8), position: CGPoint.withPercent(40, y: 50), zPosition: GameConfig.zPosition.layer_3)
    
    let shareBtn = Button(normalName: "shareBtn", size: CGSize.withPercent(35, height: 8), position: CGPoint.withPercent(60, y: 50), zPosition: GameConfig.zPosition.layer_3)
    
    let rateBtn = Button(normalName: "rateBtn", size: CGSize.withPercent(35, height: 8), position: CGPoint.withPercent(80, y: 50), zPosition: GameConfig.zPosition.layer_3)
    
    let scoreLbl = Label(text: "0", fontSize: 32, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.withPercent(92, y: 90), zPosition: GameConfig.zPosition.layer_4)
    
    let bestLbl = Label(text: "最高分: 0", fontSize: 35, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.withPercent(50, y: 20), zPosition: GameConfig.zPosition.layer_3)
    
    let backBtn = Button(normalName: "backBtn", size: CGSize.withPercentScaled(roundByWidth: 14), position: CGPoint.withPercent(8, y: 90), zPosition: GameConfig.zPosition.layer_3)
    
    override func didMove(to view: SKView) {
        soundBtn.setSwitchState(UserDefaults.standard.bool(forKey: SoundConfig.playSounds))
        soundBtn.delegate = self
    }
    
    func changeToggleButtonState(_ sender: ToggleButton) {
        Sounds.sharedInstance().changeSoundAndMusicState()
    }
    
    func addChild(_ button: Button) {
        buttons.append(button)
        super.addChild(button)
    }
    
    func addChild(_ nodes: [SKNode]) {
        for (_, value) in nodes.enumerated() {
            if value.isKind(of: Button.self) {
                addChild(value as! Button)
            }
            else {
                addChild(value)
            }
        }
    }
    
    /**
     We can call this func for change all buttons state on scene to simple.
     */
    func touchUpAllButtons() {
        for button in buttons { button.touchUp()}
    }
    
    func touchDownButtons(atLocation location: CGPoint) {
        
        for (_ ,button) in buttons.enumerated() {
            button.touchDown(ifInLocation: location)
        }
    }
    
    func changeSceneTo(scene : SKScene) {
        
        Sounds.sharedInstance().sceneForPlayingSounds = scene
        
        //Show new scene
        view?.presentScene(scene)
        
        //Clean old scene after show new
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    func changeSceneTo(scene : SKScene, withTransition transition: SKTransition) {
        
        Sounds.sharedInstance().sceneForPlayingSounds = scene
        
        //Show new scene
        view?.presentScene(scene, transition: transition)
        
        //Clean old scene after show new
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    func rateUs() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "rateUs"), object: nil)
    }
    
    func share() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "share"), object: nil)
    }
    
    func showLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showLeaderboard"), object: nil)
    }
    
    func getLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "getLeaderboard"), object: nil)
    }
    
    func submitScore() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "submitScore"), object: nil)
    }
    
    func setSoundBtn(_ size:CGSize, _ position:CGPoint) {
        soundBtn.size = size
        soundBtn.position = position
    }
    
    func setRankingBtn(_ size:CGSize, _ position:CGPoint) {
        rankingBtn.size = size
        rankingBtn.position = position
    }
    
    func setScoreLbl(_ fontSize:CGFloat, _ color:UIColor, _ position:CGPoint) {
        scoreLbl.fontSize = fontSize
        scoreLbl.color = color
        scoreLbl.position = position
    }
    
    func setBestLbl(_ fontSize:CGFloat, _ color:UIColor, _ position:CGPoint) {
        bestLbl.fontSize = fontSize
        bestLbl.color = color
        bestLbl.position = position
    }
    
    func setScore() {
        score = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
        best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        
        scoreLbl.text = "Score: " + String(score)
        bestLbl.text = "最高分: " + String(best)
    }
    
    /**
     This function helped to clean old scene from something nodes and actions
     */
    @objc func cleanOldScene() {
        removeAllChildren()
        removeAllActions()
        removeFromParent()
        print("GlobalScene: Old scene is been cleaned")
    }
    
    func makeScreenshot() {
        //Create the image
        UIGraphicsBeginImageContext(CGSize(width: frame.size.width, height: frame.size.height))
        view?.drawHierarchy(in: frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        //Save screen shot
        UserDefaults.standard.set(image!.pngData(), forKey: "ScreenShot");
    }
    
    func startToCreateBGObject() {
        //Preload objects
        preloadStars()
        
        //Start to generate bg objects
        generateStars()
    }
    
    //Stars
    
    @objc func generateStars() {
        if generateBGObjectsNow {
            for _ in 0...Int(from: GameConfig.generateStarsFrom, to: GameConfig.generateStarsTo) {
                createStar(withPreloadedType: false)
            }
            
            //Generate star again
            Timer.scheduledTimer(timeInterval: Double(from: GameConfig.generateStarTimeFrom, to: GameConfig.generateStarTimeTo), target: self, selector: #selector(generateStars), userInfo: nil, repeats: false)
        }
    }
    
    func preloadStars() {
        for _ in 0...Int(from: GameConfig.preloadedStarsCountFrom, to: GameConfig.preloadedStarsCountTo) {
            createStar(withPreloadedType: true)
        }
    }
    
    func createStar(withPreloadedType preloaded: Bool) {
        //Get values
        let position: CGPoint
        if preloaded {
            position = CGPoint(x: CGFloat(from: 0, to: VisibleRect.screenSize.width),
                               y: CGFloat(from: 0, to: VisibleRect.screenSize.height))
        }
        else {
            position = CGPoint(x: CGFloat(from: 0, to: VisibleRect.screenSize.width),
                               y: VisibleRect.screenSize.height * 1.25 +
                                CGFloat(from: 0,
                                        to: GameConfig.starShiftAtStartByMax))
        }
        
        //Createnode
        let star = Sprite(imageNamed: "jupiter", size: CGSize.withPercentScaled(roundByWidth: 2), position: position, zPosition: GameConfig.zPosition.layer_3)
        star.setScale(CGFloat(from: GameConfig.starScaleFrom, to: GameConfig.starScaleTo))
        
        //Animate
        star.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: star.position.x + (VisibleRect.screenSize.width * 1.2), y: star.position.y - (VisibleRect.screenSize.height * 2)), duration: Double(from: GameConfig.starMovingSpeedFrom, to: GameConfig.starMovingSpeedTo)),
            SKAction.removeFromParent()]))
        self.addChild(star)
    }
}
