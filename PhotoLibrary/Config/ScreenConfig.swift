//
//  ScreenConfig.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/18.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit

public class ScreenConfig: NSObject {
    
    public static let get = ScreenConfig()
    
    public var size: CGSize!
    
    public var width: CGFloat!
    
    public var height: CGFloat!
    
    override init() {
        size = UIScreen.main.bounds.size
        width = UIScreen.main.bounds.width
        height = UIScreen.main.bounds.height
    }
}
