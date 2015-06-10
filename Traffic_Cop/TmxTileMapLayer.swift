//
//  TmxTileMapLayer.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-10.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation

class TmxTileMapLayer : TileMapLayer
{
    var layer : TMXLayer
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(tmxLayer : TMXLayer)
    {
        layer = tmxLayer
        super.init(tileSize : tmxLayer.mapTileSize,
                   gridSize: tmxLayer.layerInfo.layerGridSize,
        layerSize : CGSize(width: tmxLayer.layerWidth, height: tmxLayer.layerHeight))
        
    }
}