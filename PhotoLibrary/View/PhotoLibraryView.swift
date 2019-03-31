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

    var collectionView: UICollectionView!
    
    var tableView: UITableView!
    
    let library = PhotoLibrary()
    
    var photos: PHFetchResult<PHAsset>!
    
    var albumTitle = "All Photos"
    
    var selectedImages = [PHAsset]()
    
    var delegate: PhotoViewDelegate!
    
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
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
        collectionView.register(UINib(nibName: "LibraryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
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
        indicator.color = .gray
        indicator.center = view.center
        view.addSubview(indicator)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        if library.isAuthorized() {
            photos = library.getAllPhotos()
        } else {
            library.requestPermisson()
        }
    }
    
    func collectImagea() -> [UIImage] {
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
            self.delegate.photosSelected(images: self.collectImagea())
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = albumTitle
        return cell
    }
}

extension PhotoLibraryView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = AlbumView()
        view.delegate = self
        navigationController?.pushViewController(view, animated: true)
    }
}

extension PhotoLibraryView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos == nil ? 0 : photos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LibraryCell
        cell.setData(image: photos.object(at: indexPath.row).getImagesForCollection())
        if selectedImages.contains(photos.object(at: indexPath.row)) {
            cell.setSelected()
        }
        return cell
    }
}

extension PhotoLibraryView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LibraryCell
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
        self.photos = album.getPhotos()
        self.albumTitle = album.localizedTitle!
        tableView.reloadData()
        collectionView.reloadData()
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

public protocol PhotoViewDelegate: NSObjectProtocol {
    func photosSelected(images: [UIImage])
}
