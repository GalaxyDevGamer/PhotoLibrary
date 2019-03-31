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

    var delegate: PhotoLibraryDelegate!
    
    func isAuthorized() -> Bool {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    func requestPermisson() {
        return PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case PHAuthorizationStatus.authorized:
                self.delegate.photosLoaded(assets: PHAsset.fetchAssets(with: PHAssetMediaType.image, options: PHOptionProvider.get.fetchByCreattionDate()))
            default:
                break
            }
        }
    }
    
    func getAllPhotos() -> PHFetchResult<PHAsset>{
        return PHAsset.fetchAssets(with: PHAssetMediaType.image, options: PHOptionProvider.get.fetchByCreattionDate())
    }
    
    func getAlbums() -> [PHAssetCollection] {
        var albums = [PHAssetCollection]()
        PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: PHOptionProvider.get.fetchWithNil()).enumerateObjects { (collection, int, UnsafeMutablePointer) in
            albums.append(collection)
        }
        PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: PHOptionProvider.get.fetchWithNil()).enumerateObjects { (collection, index, UnsafeMutablePointer) in
            albums.append(collection)
        }
        return albums
    }
}

public protocol PhotoLibraryDelegate: NSObjectProtocol {
    func photosLoaded(assets: PHFetchResult<PHAsset>)
}

public class PHOptionProvider: NSObject {
    
    static let get = PHOptionProvider()
    
    let options = PHImageRequestOptions()
    
    override init() {
        super.init()
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .opportunistic
    }
}

extension PHOptionProvider {
    func fetchWithNil() -> PHFetchOptions {
        let options = PHFetchOptions()
        return options
    }
    
    func fetchByCreattionDate() -> PHFetchOptions {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        return options
    }
    
    func fetchByLocalIdentifier() -> PHFetchOptions {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "localIdentifier", ascending: false)
        ]
        return options
    }
}
