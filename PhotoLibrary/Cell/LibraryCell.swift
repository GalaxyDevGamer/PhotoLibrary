//
//  LibraryCell.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/31.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit

public class LibraryCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
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
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setData(image: UIImage) {
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
