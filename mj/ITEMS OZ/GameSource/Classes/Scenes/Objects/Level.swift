//
//  Level.swift
//  Move Rio
//
//  Created by Duy on 6/23/19.
//  Copyright © 2019 Cao Nguyen Duy. All rights reserved.
//

import Foundation
import SpriteKit

class Level: Button {
    var type: Int = 1
    var label = Label(text: "1", fontSize: 30, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_5)
    override init() {
        super.init(normalName: "level", size: CGSize.withPercentScaled(roundByWidth: 20), position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_4)
        label.position = position
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
