//
//  LibraryCell.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/31.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit

public class PhotoCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.contentMode = ContentMode.scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    public var isChecked = false
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        self.isSelected = false
        setDeselected()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(image: UIImage) {
        imageView.image = image
    }
    
    public func setSelected() {
        isChecked = true
        layer.borderColor = UIColor.green.cgColor
    }
    
    public func setDeselected() {
        isChecked = false
        layer.borderColor = UIColor.clear.cgColor
    }
}

class AlbumTableCellByCode: UITableViewCell {
    
    let content: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thumbnailView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 16, y: 8, width: 80, height: 80))
        view.contentMode = ContentMode.scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 96, y: 8, width: 200, height: 50))
        view.numberOfLines = 0
        view.textAlignment = NSTextAlignment.left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let countLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 96, y: 58, width: 200, height: 50))
        view.numberOfLines = 0
        view.textAlignment = NSTextAlignment.left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = AccessoryType.disclosureIndicator
        addSubview(content)
        content.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        content.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        content.rightAnchor.constraint(equalTo: rightAnchor, constant:  0).isActive = true
        content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        content.heightAnchor.constraint(equalToConstant: 100).isActive = true
        content.addSubview(thumbnailView)
        content.addSubview(titleLabel)
        content.addSubview(countLabel)
        thumbnailView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        thumbnailView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        thumbnailView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        thumbnailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 9.5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant:  16).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(thumbnail: UIImage, title: String, count: Int) {
        thumbnailView.image = thumbnail
        titleLabel.text = title
        countLabel.text = String(count)
    }
}

class AlbumCollectionCellByCode: UICollectionViewCell {
    
    let rootView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenConfig.get.width/2-7, height: ScreenConfig.get.width/2-7))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thumbnailView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenConfig.get.width/2-7, height: ScreenConfig.get.width/2-7))
        view.contentMode = ContentMode.scaleAspectFill
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 0, y: ScreenConfig.get.width/2-7+8, width: ScreenConfig.get.width, height: 30))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    
    let countLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 0, y: ScreenConfig.get.width/2-7+38, width: ScreenConfig.get.width, height: 30))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setData(thumbnail: UIImage, title: String, count: Int) {
        thumbnailView.image = thumbnail
        titleLabel.text = title
        countLabel.text = String(count)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //                addSubview(rootView)
        //                rootView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        //                rootView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        //                rootView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        //                rootView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        //                rootView.addSubview(thumbnailView)
        //                rootView.addSubview(titleLabel)
        //                rootView.addSubview(countLabel)
        addSubview(thumbnailView)
        addSubview(titleLabel)
        addSubview(countLabel)
        thumbnailView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        thumbnailView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        thumbnailView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        //        thumbnailView.widthAnchor.constraint(equalToConstant: 284).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant: 284).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 1).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1).isActive = true
        countLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
