//
//  CarouselCell.swift
//  Image Machine
//
//  Created by Juanita Vyatri on 24/11/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import UIKit
import Eureka
import Photos
import SimpleImageViewer

open class CarouselCell: Cell<String>, CellType, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var addButton: UIButton!
    var Images = [String]()
    var phAssets = [PHAsset]()
    @IBOutlet weak var clView: UICollectionView!
    var CarouselRow: CarouselRow_! {
        return row as? CarouselRow_
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        clView.delegate = self
        clView.dataSource = self
    }

    override open func update() {
        super.update()
        Images = CarouselRow.Images
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: Images, options:nil)
        phAssets.removeAll()
        if assets.count > 0 {
            for i in 0 ..< assets.count {
                phAssets.append(assets.object(at: i))
            }
        }
        if (CarouselRow.isEditingMode) {
            addButton.removeTarget(nil, action: nil, for: .allEvents)
            addButton.addTarget(CarouselRow.addButtonTarget, action: CarouselRow.addButtonAction, for: .touchUpInside)
            clView.isHidden = (Images.count < 1) ? true : false
            addButton.isEnabled = (Images.count < 10) ? true : false
            addButton .setTitle("+ Add Images", for: .normal)
        } else {
            if (phAssets.count > 0) {
                clView.isHidden = false
                addButton.isHidden = true
            } else {
                addButton .setTitle("No images here", for: .disabled)
                clView.isHidden = true
            }
            addButton.isEnabled = false
        }
        clView.reloadData()
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phAssets.count
    }
    
    private func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.closeButton.removeTarget(nil, action: nil, for: .allEvents)
        if (CarouselRow.isEditingMode) {
            cell.setData(phAssets[indexPath.item], isEditingMode: true)
            cell.closeButton.layer.setValue(indexPath, forKey: "indexpath")
            cell.closeButton.addTarget(self, action: #selector(removeImage(_:)), for: .touchUpInside)
        } else {
            cell.setData(phAssets[indexPath.item], isEditingMode: false)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: ImageCell = collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems![0]) as! ImageCell
        let configuration = ImageViewerConfiguration { config in
            config.imageView = cell.imagevw
        }
        
        let imageViewerController = ImageViewerController(configuration: configuration)
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(imageViewerController, animated: true, completion: nil)
        }
    }
    
    @objc func removeImage(_ sender:UIButton) {
        let indexpath: IndexPath = sender.layer.value(forKey: "indexpath") as! IndexPath
        Images = Images.filter { $0 != phAssets[indexpath.item].localIdentifier }
        phAssets.remove(at: indexpath.item)
        CarouselRow.Images = Images
        clView.reloadData()
    }
}

open class CarouselRow_: Row<CarouselCell> {
    
    open var Images = [String]()
    open var isEditingMode: Bool = false
    open var addButtonAction: Selector!
    open var addButtonTarget: UIViewController!
    
    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<CarouselCell>(nibName: "CarouselCell")
    }
}

public final class CarouselRow: CarouselRow_, RowType { }
