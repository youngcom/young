//
//  GameViewController.swift
//  GameSource
//
//  Created by Mr. Joker on 3/21/19.
//  Copyright © 2019 Mr. Joker. All rights reserved.
//

import UIKit
import SpriteKit

import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if !(UserDefaults.standard.bool(forKey: GameConfig.hasLaunchedOnce)) {
            //First launch
            UserDefaults.standard.set(true, forKey: GameConfig.hasLaunchedOnce)
            
            //Set stats
            UserDefaults.standard.set(true, forKey: SoundConfig.playSounds)
            UserDefaults.standard.set(true, forKey: SoundConfig.playMusic)

            UserDefaults.standard.set(0, forKey: GameConfig.currentScore)
            UserDefaults.standard.set(0, forKey: GameConfig.bestScore)
            
            UserDefaults.standard.set(false, forKey: GameConfig.neverRateAfterGame)
        }
        
        // create game view
        if let view = self.view as! SKView? {
            // load scene
            let scene = MenuScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.presentScene(scene)

            // load observers
            createObserversToGameSceneController()
            
            Sounds.sharedInstance().playMusic(musicName: SoundConfig.musicGame)
            Sounds.sharedInstance().sceneForPlayingSounds = scene
            
         
            authenticateLocalPlayer()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func createObserversToGameSceneController() {
        NotificationCenter.default.addObserver(self, selector: #selector(showLeaderboard), name: NSNotification.Name(rawValue: "showLeaderboard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(submitScore), name: NSNotification.Name(rawValue: "submitScore"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(rateUs), name: NSNotification.Name(rawValue: "rateUs"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(rateUsAfterGame), name: NSNotification.Name(rawValue: "rateUsAfterGame"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(share), name: NSNotification.Name(rawValue: "share"), object: nil)
    }
}
