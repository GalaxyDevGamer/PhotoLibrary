//
//  PHAssetExtension.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/20.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import Foundation
import Photos

public extension PHAsset {
    func getImagesForCollection() -> UIImage {
        var thumbnail = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: self, targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let safeImage = image {
                thumbnail = safeImage
            }
        }
        return thumbnail!
    }
    
    func getOriginalImage() -> UIImage {
        var original = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail
            }
        }
        return original!
    }
    
    func getImageForTheBoard() -> UIImage {
        var original = UIImage(named: "Image48pt")
        if ScreenConfig.get.boardSize == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        PHImageManager.default().requestImage(for: self, targetSize: ScreenConfig.get.boardSize, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail
            }
        }
        return original!
    }
    
    func getOriginalAndResize() -> UIImage {
        var original = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail.resizeForFullScreen()
            }
        }
        return original!
    }
}
