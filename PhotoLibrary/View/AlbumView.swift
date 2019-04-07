//
//  AlbumView.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/31.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit
import Photos

public class AlbumView: UIViewController {
    
    var tableView: UITableView = LibraryViewConfigs.get.albumTableView
    
    var collectionView: UICollectionView = LibraryViewConfigs.get.albumCollectionView
    
    var board: UIView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenConfig.get.width, height: ScreenConfig.get.height))
    
    public var delegate: AlbumViewDelegate!
    
    let library = PhotoLibrary()
    
    var thumbnails = [Album]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "Collection24pt"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(tileClick)), UIBarButtonItem(image: UIImage(named: "List24pt"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(listClick))]
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        view.addSubview(board)
        board.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0).isActive = true
        board.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 0).isActive = true
        board.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: 0).isActive = true
        board.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0).isActive = true
        board.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        board.isHidden = true
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        thumbnails = library.getInformationFromGivenCollection(collections: library.getAlbums())
    }
    
    @objc func tileClick() {
        board.isHidden = true
    }
    
    @objc func listClick() {
        board.isHidden = false
    }
}

extension AlbumView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thumbnails.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumTableCellByCode
        let album = thumbnails[indexPath.row]
        cell.set(thumbnail: album.thumbnail, title: album.title, count: album.count)
        return cell
    }
}

extension AlbumView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.onAlbumSelected(album: thumbnails[indexPath.row].photos)
        navigationController?.popViewController(animated: true)
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 276
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AlbumView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnails.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumCollectionCellByCode
        let album = thumbnails[indexPath.row]
        cell.set(thumbnail: album.thumbnail, title: album.title, count: album.count)
        return cell
    }
}

extension AlbumView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate.onAlbumSelected(album: thumbnails[indexPath.row].photos)
        navigationController?.popViewController(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2-7, height: self.view.frame.size.width/2-7+66)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

public protocol AlbumViewDelegate: NSObjectProtocol {
    func onAlbumSelected(album: PHAssetCollection)
}

public struct Album {
    var photos: PHAssetCollection
    var thumbnail: UIImage
    var title: String
    var count: Int
}
