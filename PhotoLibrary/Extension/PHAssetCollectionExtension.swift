//
//  PHAssetCollectionExtension.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/30.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import Foundation
import Photos

public extension PHAssetCollection {
    func getPhotos() -> PHFetchResult<PHAsset> {
        return PHAsset.fetchAssets(in: self, options: PHOptionProvider.get.fetchByCreattionDate())
    }
}
