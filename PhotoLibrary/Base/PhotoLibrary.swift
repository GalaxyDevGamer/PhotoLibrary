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
    
    public var delegate: PhotoLibraryDelegate!
    
    public func isAuthorized() -> Bool {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    public func requestPermisson() {
        return PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case PHAuthorizationStatus.authorized:
                self.delegate.photosLoaded(assets: PHAsset.fetchAssets(with: PHAssetMediaType.image, options: PHOptionProvider.get.fetchByCreattionDate()))
            default:
                break
            }
        }
    }
    
    public func getAllPhotos() -> PHFetchResult<PHAsset>{
        return PHAsset.fetchAssets(with: PHAssetMediaType.image, options: PHOptionProvider.get.fetchByCreattionDate())
    }
    
    public func getAlbums() -> [PHAssetCollection] {
        var albums = [PHAssetCollection]()
        PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: PHOptionProvider.get.fetchWithNil()).enumerateObjects { (collection, int, UnsafeMutablePointer) in
            albums.append(collection)
        }
        PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: PHOptionProvider.get.fetchWithNil()).enumerateObjects { (collection, index, UnsafeMutablePointer) in
            albums.append(collection)
        }
        return albums
    }
    
    public func getAlbumWithExcludingEmptyAlbum() -> [PHAssetCollection] {
        var albums = [PHAssetCollection]()
        PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: PHOptionProvider.get.fetchWithNil()).enumerateObjects { (collection, int, UnsafeMutablePointer) in
            if collection.estimatedAssetCount > 0 {
                albums.append(collection)
            }
        }
        PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: PHOptionProvider.get.fetchWithNil()).enumerateObjects { (collection, index, UnsafeMutablePointer) in
            if collection.estimatedAssetCount > 0 {
                albums.append(collection)
            }
        }
        return albums
    }
    
    public func getThumbnail(photos: PHFetchResult<PHAsset>) -> UIImage {
        if photos.count == 0 {
            return UIImage()
        }
        return photos[0].getImagesForCollection()
    }
    
    func getInformationFromGivenCollection(collections: [PHAssetCollection]) -> [Album]{
        var infomations = [Album]()
        collections.forEach { (collection) in
            let photos = collection.getPhotos()
            if photos.count > 0 {
                infomations.append(Album(photos: collection, thumbnail: getThumbnail(photos: photos), title: collection.localizedTitle!, count: photos.count))
            }
        }
        return infomations
    }
}

public protocol PhotoLibraryDelegate: NSObjectProtocol {
    func photosLoaded(assets: PHFetchResult<PHAsset>)
}

public class PHOptionProvider: NSObject {
    
    public static let get = PHOptionProvider()
    
    public let options = PHImageRequestOptions()
    
    override init() {
        super.init()
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .opportunistic
    }
}

extension PHOptionProvider {
    public func fetchWithNil() -> PHFetchOptions {
        let options = PHFetchOptions()
        return options
    }
    
    public func fetchByCreattionDate() -> PHFetchOptions {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        return options
    }
    
    public func fetchByLocalIdentifier() -> PHFetchOptions {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "localIdentifier", ascending: false)
        ]
        return options
    }
}
