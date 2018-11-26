//
//  ImageCell.swift
//  Image Machine
//
//  Created by Juanita Vyatri on 24/11/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import UIKit
import Photos

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imagevw: UIImageView!
    let imgManager = PHImageManager.default()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ image: PHAsset, isEditingMode: Bool) {
        imagevw.image = nil
        imgManager.requestImage(for: image, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { (img, err) in
            self.imagevw.image = img
        }
        closeButton.isHidden = (isEditingMode) ? false : true
    }
}
