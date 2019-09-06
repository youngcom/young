//
//  GS_Interface.swift
//  Math Simple
//
//  Created by Mr. Joker on 4/9/19.
//  Copyright © 2019 Mr. Joker. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func createBoard() {
        var cols = 0
        var rows = 0
        var type1Count = 0
        var type2Count = 0
        var type3Count = 0
        var type4Count = 0
        let level = UserDefaults.standard.integer(forKey: "level")
        
        if level <= 4 && level >= 1 {
            cols = level + 1
            rows = 1
        }
        
        if level >= 5 && level <= 7 {
            cols = level - 2
            rows = 3
        }
        
        if level >= 8 && level <= 14 {
            cols = level - 5
            rows = 4
        }
        
        if level >= 15 && level <= 20 {
            cols = level - 6
            rows = 6
        }
        
        let xScale:CGFloat = CGFloat(0.65*VisibleRect.screenSize.width/CGFloat(cols))
        let yScale:CGFloat = CGFloat(0.65*VisibleRect.screenSize.height/CGFloat(rows))
        let sizeOfCell = (xScale < yScale) ? (xScale) : (yScale)
        
        for _ in 0...cols - 1 {
            for _ in 0...rows - 1 {
                let circle = Circle()
                circle.size = CGSize(width: sizeOfCell, height: sizeOfCell)
                addChild(circle)
                circles.append(circle)
                switch circle.type {
                case 1:
                    type1Count += 1
                case 2:
                    type2Count += 1
                case 3:
                    type3Count += 1
                default:
                    type4Count += 1
                }
            }
        }
        var typeCountArr = [type1Count, type2Count, type3Count, type4Count]
        let typeMax = typeCountArr.max()
        for type in typeCountArr {
            if typeMax == type {
                let index = typeCountArr.index(of: type)!
                typeCountArr[index] = 0
                maxTypes.append(index+1)
            }
        }
        GameViewHelper.alignItemsRowsAndCols(padding: 10, rows: rows, cols: cols, items: circles, position: CGPoint.withPercent(50, y: 62))
    }
}
