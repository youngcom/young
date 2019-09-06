//
//  ToggleButton.swift
//  GameSource
//
//  Created by Mr. Joker on 4/7/19.
//  Copyright © 2019 Mr. Joker. All rights reserved.
//

import SpriteKit

protocol ToggleButtonDelegate {
    func changeToggleButtonState(_ sender: ToggleButton)
}

class ToggleButton : Sprite {
    var currentState = true
    
    fileprivate var imageOn: String?
    fileprivate var imageOff: String?
    
    var delegate: ToggleButtonDelegate?
    
    /**
     Initialisation of switch node.
     
     - property textureOnState: SKTexture object of texture switch in on state.
     - property textureOffState: SKTexture object of texture switch in off state.
     - property size: CGSize object with size of node.
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(imageOn: String, imageOff: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageOn, size: size, position: position, zPosition: zPosition)
        
        self.imageOn = imageOn
        self.imageOff = imageOff
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("ButtonNode init(coder:) has not been implemented")}
    
    //MARK: - Switch Logic
    
    /**
     Private function for update texture by current state
     */
    fileprivate func updateSwitchTexture() {
        if currentState { texture = SKTexture.init(imageNamed: "Images/" + imageOn!)}
        else { texture = SKTexture.init(imageNamed: "Images/" + imageOff!)}
    }
    
    /**
     Change switch state. You can use delegate method for realise some action after changing state some atribut.
     */
    func changeSwitchState() {
        currentState = !currentState
        updateSwitchTexture()
        Sounds.sharedInstance().playSound(soundName: SoundConfig.soundButton)
        
        //Send message for delegate method. If current switch object have delegate.
        if delegate != nil {
            delegate?.changeToggleButtonState(self)
        }
    }
    
    func changeSwitchState(ifInLocation location: CGPoint) {
        if contains(location) {
            changeSwitchState()
        }
    }
    
    /**
     Set switch state. It's method for setting start state of switch if you load new scene
     */
    func setSwitchState(_ isOn: Bool) {
        currentState = isOn
        updateSwitchTexture()
    }
}
