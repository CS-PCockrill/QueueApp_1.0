//
//  ItemImageCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class ItemImageCell: UICollectionViewCell {
    
    //    var image: Image? {
    //        didSet {
    //            if let image = image?.imageName {
    //                photoImageView.image = image
    //            }
    //        }
    //    }
    func configureImageCell(image: UIImage) {
        photoImageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.masksToBounds = true
        //        layer.borderColor = UIColor.gray.cgColor
        //        layer.borderWidth = 0.5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    fileprivate func setupViews() {
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}

class Image: NSObject {
    let imageName: UIImage
    
    init(imageName: UIImage) {
        self.imageName = imageName
    }
}
