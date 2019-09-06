//
//  Character.swift
//  Template
//
//  Created by Cao Nguyễn Duy on 5/15/19.
//  Copyright © 2019 Viet Nguyen. All rights reserved.
//

import Foundation
import SpriteKit

class Circle: Sprite {
    var type: Int = 1
    override init() {
        super.init(imageNamed: "1", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_3)
        randomColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomColor() {
        let num = Int.random(in: 1...4)
        type = num
        texture = SKTexture(imageNamed: "Images/\(num)")
    }
}
