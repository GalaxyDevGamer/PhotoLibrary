//
//  LibraryCell.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/31.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit

public class LibraryCell: UICollectionViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    
    public var isChecked = false
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        self.isSelected = false
        setDeselected()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.clear.cgColor
    }
    
    public func setData(image: UIImage) {
        thumbnail.image = image
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
