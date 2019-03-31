//
//  ScreenConfig.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/18.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit

public class ScreenConfig: NSObject {

    static let get = ScreenConfig()
    
    public var size: CGSize!
    
    public var width: CGFloat!
    
    public var height: CGFloat!
    
    public var boardSize: CGSize!
    
    public func initialize(screenSize: CGSize) {
        size = screenSize
        width = size.width
        height = size.height
        boardSize = CGSize(width: width, height: height)
    }
}
