//
//  PhotoLibraryView.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/18.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit
import Photos

public class PhotoLibraryView: UIViewController {
    
    let tableView = LibraryViewConfigs.get.albumTitleTableView
    
    let collectionView = LibraryViewConfigs.get.photoCollectionView
    
    let library = PhotoLibrary()
    
    var photos: PHFetchResult<PHAsset>!
    
    var album: PHAssetCollection!
    
    public var selectedImages = [PHAsset]()
    
    weak open var delegate: PhotoLibraryViewDelegate!
    
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    let albumView = AlbumView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Close24pt"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeClick))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClick))
        view.addSubview(tableView)
        view.addSubview(collectionView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.size.height).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 145).isActive = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.topAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        library.delegate = self
        albumView.delegate = self
        indicator.color = .gray
        indicator.center = view.center
        view.addSubview(indicator)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        if library.isAuthorized() {
            if album != nil {
                photos = album.getPhotos()
            } else {
                photos = library.getAllPhotos()
            }
        } else {
            library.requestPermisson()
        }
    }
    
    func collectImages() -> [UIImage] {
        indicator.startAnimating()
        var images = [UIImage]()
        self.selectedImages.forEach { (asset) in
            images.append(asset.getOriginalImage())
        }
        indicator.stopAnimating()
        return images
    }
    
    @objc func doneClick() {
        dismiss(animated: true) {
            self.delegate.photosSelected(images: self.collectImages(), assets: self.selectedImages)
        }
    }
    
    @objc func closeClick() {
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoLibraryView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumTableCellByCode
        cell.set(thumbnail: photos.object(at: 0).getImagesForCollection(), title: album == nil ? "All Photos" : album.localizedTitle!, count: photos.count)
        return cell
    }
}

extension PhotoLibraryView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(albumView, animated: true)
    }
}

extension PhotoLibraryView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos == nil ? 0 : self.photos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        cell.set(image: photos.object(at: indexPath.row).getImagesForCollection())
        if selectedImages.contains(photos.object(at: indexPath.row)) {
            cell.setSelected()
        }
        return cell
    }
}

extension PhotoLibraryView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        if cell.isChecked {
            selectedImages.remove(at: selectedImages.firstIndex(of: photos.object(at: indexPath.row))!)
            cell.setDeselected()
        } else {
            selectedImages.append(photos.object(at: indexPath.row))
            cell.setSelected()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/3-7, height: self.view.frame.size.width/3-7)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension PhotoLibraryView: AlbumViewDelegate {
    public func onAlbumSelected(album: PHAssetCollection) {
        self.album = album
        photos = album.getPhotos()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
}

extension PhotoLibraryView: PhotoLibraryDelegate {
    public func photosLoaded(assets: PHFetchResult<PHAsset>) {
        photos = assets
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

public protocol PhotoLibraryViewDelegate: NSObjectProtocol {
    func photosSelected(images: [UIImage], assets: [PHAsset])
}
