//
//  GameConfig.swift
//  GameSource
//
//  Created by Cao Nguyen Duy on 17/6/19.
//  Copyright © 2019 Cao Nguyen Duy. All rights reserved.
//

import Foundation
import SpriteKit

struct GameConfig {
    static let currentScore = "CurrentScore"
    static let bestScore = "BestScore"
    
    static let hasLaunchedOnce = "HasLaunchedOnce"
    static let neverRateAfterGame =  "NeverRateAfterGame"
    
    static let fontText:String = UIFont.familyNames[0]
    static let fontNumber:String = UIFont.familyNames[1]
    
    struct zPosition {
        static let layer_1:CGFloat = 0
        static let layer_2:CGFloat = 1
        static let layer_3:CGFloat = 2
        static let layer_4:CGFloat = 3
        static let layer_5:CGFloat = 4
        static let layer_6:CGFloat = 5
        static let layer_7:CGFloat = 6
        static let layer_8:CGFloat = 7
    }
    
    static let particleCrushCountFrom: Int = 35
    static let particleCrushCountTo: Int = 40
    static let particleCrushScaleFrom: CGFloat = 1.0
    static let particleCrushScaleTo: CGFloat = 1.95
    static let particleCrushLifetimeFrom: Double = 0.2
    static let particleCrushLifetimeTo: Double = 0.4
    static let particleMoveByMax: CGFloat = VisibleRect.screenSize.width / 100 * 17.5
    
    //STAR
    static let preloadedStarsCountFrom: Int = 50
    static let preloadedStarsCountTo: Int = 70
    
    static let generateStarsFrom: Int = 6
    static let generateStarsTo: Int = 14
    
    static let starShiftAtStartByMax: CGFloat = VisibleRect.screenSize.height / 100 * 5
    
    static let starMovingSpeedFrom: Double = 5.6
    static let starMovingSpeedTo: Double = 11.6
    
    static let starScaleFrom: CGFloat = 0.5
    static let starScaleTo: CGFloat = 1.0
    
    static let generateStarTimeFrom: Double = 0.95
    static let generateStarTimeTo: Double = 1.5
    
    //BGOBJ
    static let bgObjectScaleFrom: CGFloat = 0.5
    static let bgObjectScaleTo: CGFloat = 1.0
    
    static let bgObjectMovingSpeedFrom: Double = 5.6
    static let bgObjectMovingSpeedTo: Double = 11.6
    
    static let generateBgObjectTimeFrom: Double = 1.25
    static let generateBgObjectTimeTo: Double = 3.25
    
    struct CollisionCategory {
        static let iceCream: UInt32 = 1
        static let car: UInt32 = 2
    }
}
