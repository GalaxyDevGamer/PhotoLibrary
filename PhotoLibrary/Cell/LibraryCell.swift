//
//  LibraryCell.swift
//  PhotoLibrary
//
//  Created by GINGA WATANABE on 2019/03/31.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit

class LibraryCell: UICollectionViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    
    var indexInSelection = 0
    
    var isChecked = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isSelected = false
        setDeselected()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.clear.cgColor
    }
    
    func setData(image: UIImage) {
        thumbnail.image = image
    }
    
    func setSelected() {
        isChecked = true
        layer.borderColor = UIColor.green.cgColor
    }
    
    func setDeselected() {
        isChecked = false
        layer.borderColor = UIColor.clear.cgColor
    }
}
