//
//  ItemOverviewCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/20/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class OfferItemDetailsCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
//        backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let itemTitleLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    let profileNameLabel = UILabel(text: "Patrick Cockrill", font: .systemFont(ofSize: 17))
    
    let itemImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "patrick")
        image.clipsToBounds = true
        return image
    }()
    
    fileprivate func layoutViews() {
        addSubview(itemTitleLabel)
        addSubview(itemImageView)
        addSubview(profileImageView)
        addSubview(profileNameLabel)
        
        itemImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 16, paddingRight: 8, width: 150 - 24, height: 0)
        itemTitleLabel.anchor(top: topAnchor, left: itemImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: itemTitleLabel.intrinsicContentSize.height)
        profileImageView.anchor(top: nil, left: itemImageView.rightAnchor, bottom: itemImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 20
        
        profileNameLabel.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: profileImageView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
