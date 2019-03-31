//
//  SinglePhotoLibraryView.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/31.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit
import Photos

public class SinglePhotoLibraryView: UIViewController {

    var tableView: UITableView!
    
    var collectionView: UICollectionView!
    
    let library = PhotoLibrary()
    
    var photos: PHFetchResult<PHAsset>!
    
    var albumTitle = "All Photos"
    
    weak open var delegate: SinglePhotoLibraryViewDelegate!
    
    var selectedAsset: PHAsset!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Close24pt"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeClick))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClick))
        ScreenConfig.get.initialize(screenSize: view.frame.size)
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        collectionLayout.itemSize = CGSize(width: self.view.frame.size.width/3-7, height: self.view.frame.size.width/3-7)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height-50), collectionViewLayout: collectionLayout)
        self.collectionView!.register(UINib(nibName: "LibraryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.size.height).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        library.delegate = self
        if library.isAuthorized() {
            photos = library.getAllPhotos()
        } else {
            library.requestPermisson()
        }
    }
    
    @objc func doneClick() {
        dismiss(animated: true) {
            self.delegate.photoSelected(image: self.selectedAsset.getOriginalImage())
        }
    }
    
    @objc func closeClick() {
        dismiss(animated: true, completion: nil)
    }
}

extension SinglePhotoLibraryView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = albumTitle
        return cell
    }
}

extension SinglePhotoLibraryView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = AlbumView()
        view.delegate = self
        navigationController?.pushViewController(view, animated: true)
    }
}

extension SinglePhotoLibraryView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos == nil ? 0 : photos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LibraryCell
        cell.setData(image: photos.object(at: indexPath.row).getImagesForCollection())
        for index in collectionView.indexPathsForSelectedItems! {
            if index == indexPath {
                cell.setSelected()
            }
        }
        return cell
    }
}

extension SinglePhotoLibraryView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LibraryCell
        cell.setSelected()
        selectedAsset = photos.object(at: indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LibraryCell
        cell.setDeselected()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/3-7, height: self.view.frame.size.width/3-7)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension SinglePhotoLibraryView: AlbumViewDelegate {
    public func onAlbumSelected(album: PHAssetCollection) {
        self.photos = album.getPhotos()
        self.albumTitle = album.localizedTitle!
        tableView.reloadData()
        collectionView.reloadData()
    }
}

extension SinglePhotoLibraryView: PhotoLibraryDelegate {
    public func photosLoaded(assets: PHFetchResult<PHAsset>) {
        photos = assets
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

public protocol SinglePhotoLibraryViewDelegate: NSObjectProtocol {
    func photoSelected(image: UIImage) -> Void
}
