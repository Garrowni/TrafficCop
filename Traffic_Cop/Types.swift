//
//  Types.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-24.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

struct PhysicsCategory
{
    static let None     : UInt32 = 0
    static let All      : UInt32 = UInt32.max
    static let Car      : UInt32 = 0b1
    static let Person   : UInt32 = 0b10
}
