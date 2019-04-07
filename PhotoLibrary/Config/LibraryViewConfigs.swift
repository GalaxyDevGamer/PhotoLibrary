//
//  LibraryViewConfigs.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/04/07.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit

public class LibraryViewConfigs: NSObject {
    
    static public let get = LibraryViewConfigs()
    
    public let albumTitleTableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenConfig.get.width, height: 100), style: UITableView.Style.plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isScrollEnabled = false
        return view
    }()
    
    public let photoCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        collectionLayout.itemSize = CGSize(width: ScreenConfig.get.width/3-7, height: ScreenConfig.get.width/3-7)
        let view = UICollectionView(frame: CGRect(x: 0, y: 100, width: ScreenConfig.get.width, height: ScreenConfig.get.height-100), collectionViewLayout: collectionLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    public var albumTableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenConfig.get.width, height: ScreenConfig.get.height))
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var albumCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        collectionLayout.itemSize = CGSize(width: ScreenConfig.get.width/2-7, height: ScreenConfig.get.width/2-7)
        let view = UICollectionView(frame: CGRect(x: 0, y: 50, width: ScreenConfig.get.width, height: ScreenConfig.get.height-50), collectionViewLayout: collectionLayout)
        view.register(AlbumCollectionCellByCode.self, forCellWithReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
}
