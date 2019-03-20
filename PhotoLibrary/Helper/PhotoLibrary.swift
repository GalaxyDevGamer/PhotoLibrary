//
//  PhotoLibrary.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/18.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit
import Photos

public class PhotoLibrary: NSObject {

    var allPhotos: PHFetchResult<PHAsset>!
    
    var albums = [PHFetchResult<PHAsset>]()
    
    let options = PHImageRequestOptions()
    
    weak open var delegate: PhotoLibraryDelegate?
    
    public override init() {
        super.init()
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .opportunistic
        getAllPhotos()
    }
    
    func getAllPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case PHAuthorizationStatus.authorized:
                let options = PHFetchOptions()
                options.sortDescriptors = [
                    NSSortDescriptor(key: "creationDate", ascending: false)
                ]
                self.allPhotos = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: options)
                DispatchQueue.main.async {
                    self.delegate?.photosLoaded()
                    NotificationCenter.default.post(name: NSNotification.Name("Photos are loaded"), object: nil)
                }
            case .notDetermined:
                print("Not determined")
            case .restricted, .denied:
                print("Not allowed")
            @unknown default:
                fatalError("")
            }
        }
    }
    
    func getAlbums() {
        let options = PHFetchOptions()
        
        let albums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: options)
        albums.enumerateObjects { (collection, index, UnsafeMutablePointer) in
            let result = PHAsset.fetchAssets(in: collection, options: options)
            self.albums.append(result)
        }
    }
    
    func getImagesForCollection(asset: PHAsset) -> UIImage {
        var thumbnail = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: options) { (image, info) in
            if let safeImage = image {
                thumbnail = safeImage
            }
        }
        return thumbnail!
    }
    
    func getOriginalImage(asset: PHAsset) -> UIImage {
        var original = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail
            }
        }
        return original!
    }
    
    func getImageForTheBoard(asset: PHAsset) -> UIImage {
        var original = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: asset, targetSize: ScreenConfig.get.boardSize, contentMode: PHImageContentMode.aspectFill, options: options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail
            }
        }
        return original!
    }
    
    func getOriginalAndResize(asset: PHAsset) -> UIImage {
        var original = UIImage(named: "Image48pt")
        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: options) { (image, info) in
            if let thumbnail = image {
                original = thumbnail.resizeForFullScreen()
            }
        }
        return original!
    }
}

public protocol PhotoLibraryDelegate: NSObjectProtocol {
    func photosLoaded() -> Void
}
