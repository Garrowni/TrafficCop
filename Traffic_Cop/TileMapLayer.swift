//
//  TileMapLayer.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-10.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import SpriteKit

class TileMapLayer : SKNode {
    
    let tileSize: CGSize
    var atlas: SKTextureAtlas?
    let gridSize: CGSize
    let layerSize: CGSize
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(tileSize: CGSize, gridSize: CGSize,
        layerSize: CGSize? = nil) {
            self.tileSize = tileSize
            self.gridSize = gridSize
            if layerSize != nil {
                self.layerSize = layerSize!
            } else {
                self.layerSize =
                    CGSize(width: tileSize.width * gridSize.width,
                        height: tileSize.height * gridSize.height)
            }
            super.init()
    }
    
}

