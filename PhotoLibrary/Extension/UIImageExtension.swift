//
//  ImageExtension.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/18.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import Foundation

public extension UIImage {
    func resizeForList(count: CGFloat) -> UIImage? {
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        let size = CGSize(width: ScreenConfig.get.width, height: ScreenConfig.get.height/count)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func resizeForCustomizedList(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func resizeForTile(column: CGFloat, row: CGFloat) -> UIImage {
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        let size = CGSize(width: ScreenConfig.get.width/column, height: ScreenConfig.get.height/row)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func resizeForFullScreen() -> UIImage {
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        UIGraphicsBeginImageContextWithOptions(ScreenConfig.get.size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func compositeImage(source image: UIImage, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) -> UIImage {
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        UIGraphicsBeginImageContextWithOptions(ScreenConfig.get.size, false, 0.0)
        image.draw(in: CGRect(x: x, y: y, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func resizeToHalf() -> UIImage {
        let size = CGSize(width: self.size.width*0.5, height: self.size.height*0.5)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func resizeByPercent(width: Double, height: Double) -> UIImage {
        let size = CGSize(width: Double(self.size.width)*width, height: Double(self.size.height)*height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

import SwiftUI

/*
 These are returning Image instead of UIImage
 For SwiftUI
 */
@available(iOS 13.0, *)
public extension UIImage {
    func resizeForList(count: CGFloat) -> Image {
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        let size = CGSize(width: ScreenConfig.get.width, height: ScreenConfig.get.height/count)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        UIGraphicsEndImageContext()
        
        return Image(uiImage: image)
    }
    
    func resizeForCustomizedList(width: CGFloat, height: CGFloat) -> Image {
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        UIGraphicsEndImageContext()
        
        return Image(uiImage: image)
    }
    
    func resizeForTile(column: CGFloat, row: CGFloat) -> Image {
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        let size = CGSize(width: ScreenConfig.get.width/column, height: ScreenConfig.get.height/row)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        UIGraphicsEndImageContext()
        return Image(uiImage: image)
    }
    
    func resizeForFullScreen() -> Image {
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        UIGraphicsBeginImageContextWithOptions(ScreenConfig.get.size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        UIGraphicsEndImageContext()
        return Image(uiImage: image)
    }
    
    func compositeImage(source image: UIImage, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) -> Image {
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        UIGraphicsBeginImageContextWithOptions(ScreenConfig.get.size, false, 0.0)
        image.draw(in: CGRect(x: x, y: y, width: width, height: height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        UIGraphicsEndImageContext()
        return Image(uiImage: newImage)
    }
    
    func resizeToHalf() -> Image {
        let size = CGSize(width: self.size.width*0.5, height: self.size.height*0.5)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        UIGraphicsEndImageContext()
        
        return Image(uiImage: image)
    }
    
    func resizeByPercent(width: Double, height: Double) -> Image {
        let size = CGSize(width: Double(self.size.width)*width, height: Double(self.size.height)*height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        UIGraphicsEndImageContext()
        return Image(uiImage: image)
    }
}
