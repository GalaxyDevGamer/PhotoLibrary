//
//  PHAssetExtension.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/20.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import Foundation
import SwiftUI
import Photos

@available(iOS 13.0, *)
let img = Image("Image48pt")

public extension PHAsset {
    /*
     Fetch the image for UICollectionView
     */
    func getImagesForCollection() -> UIImage {
        var thumbnail = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: self, targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let safeImage = image {
                thumbnail = safeImage
            }
        }
        return thumbnail!
    }
    
    /*
     Fetch the original image
     */
    func getOriginalImage() -> UIImage {
        var original = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail
            }
        }
        return original!
    }
    
    /*
     Fetch the images with the size of the device's screen size
     */
    func getImageForTheBoard() -> UIImage {
        var original = UIImage(named: "Image48pt")
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        PHImageManager.default().requestImage(for: self, targetSize: ScreenConfig.get.size, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail
            }
        }
        return original!
    }
    
    /*
     Fetch the image with it's maximum size and resize to device's screen size
     */
    func getOriginalAndResize() -> UIImage {
        var original = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail.resizeForFullScreen()
            }
        }
        return original!
    }
    
    /*
     Fetch the UIImage for UICollectionView and convert it to Image
     For SwiftUI
     */
    @available(iOS 13.0, *)
    func getImagesForCollection() -> Image {
        var thumbnail = img
        PHImageManager.default().requestImage(for: self, targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let safeImage = image {
                thumbnail = Image(uiImage: safeImage)
            }
        }
        return thumbnail
    }
    
    /*
     Fetch the original UIImage and convert it to Image
     For SwiftUI
     */
    @available(iOS 13.0, *)
    func getOriginalImage() -> Image {
        var original = img
        PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = Image(uiImage: thumbnail)
            }
        }
        return original
    }
    
    /*
     Fetch the UIImage with the device's screen size and convert it to Image
     For SwiftUI
     */
    @available(iOS 13.0, *)
    func getImageForTheBoard() -> Image {
        var original = img
        if ScreenConfig.get.size == nil {
            fatalError("Screen size not set on ScreenConfig. Set it by initialize")
        }
        PHImageManager.default().requestImage(for: self, targetSize: ScreenConfig.get.size, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = Image(uiImage: thumbnail)
            }
        }
        return original
    }
    
    /*
     Fetch the UIImage with it's maximum size and resize to device's screen size and convert it to Image
     For SwiftUI
     */
    @available(iOS 13.0, *)
    func getOriginalAndResize() -> Image {
        var original = img
        PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: PHOptionProvider.get.options) { (image, info) in
            if let thumbnail = image {
                original = Image(uiImage: thumbnail.resizeForFullScreen())
            }
        }
        return original
    }
}
