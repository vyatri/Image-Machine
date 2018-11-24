//
//  ImageCell.swift
//  Image Machine
//
//  Created by Juanita Vyatri on 24/11/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imagevw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ image: UIImage, isEditingMode: Bool) {
        imagevw.image = image
        closeButton.isHidden = (isEditingMode) ? false : true
    }
}
