//
//  AddImageCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/6/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class AddImageCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            layer.borderWidth = isHighlighted ? 2 : 1
            layer.borderColor = isHighlighted ? UIColor.rgb(red: 31, green: 87, blue: 245).cgColor : UIColor.gray.cgColor
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.masksToBounds = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addPhotoImage: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
//        button.image = UIImage(named: "plus_unselected")?.withRenderingMode(.alwaysOriginal)
        button.isUserInteractionEnabled = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    fileprivate func setupViews() {
        addSubview(addPhotoImage)
        addPhotoImage.isUserInteractionEnabled = false
        addPhotoImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}
