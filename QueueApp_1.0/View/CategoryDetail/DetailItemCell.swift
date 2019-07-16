//
//  DetailItemCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class DetailItemCell: UICollectionViewCell {
    
    var postItem: Item? {
        didSet {
            if let imageName = postItem?.imageName {
                photoImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(photoImageView)
        photoImageView.addSubview(priceView)
        addSubview(priceLabel)
        addSubview(titleLabel)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: titleLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titleLabel.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 25)
        priceLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 50)
        priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: priceView.centerYAnchor).isActive = true
        priceView.anchor(top: nil, left: photoImageView.leftAnchor, bottom: photoImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 50, height: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let priceView: UIView = {
        let sv = UIView()
        sv.backgroundColor = .black
        sv.layer.opacity = 0.65
        sv.layer.masksToBounds = true
        sv.layer.cornerRadius = 7.5
        return sv
    }()
    
    let photoImageView: UIImageView = {
        let pv = UIImageView()
        pv.layer.cornerRadius = 7.5
        pv.layer.masksToBounds = true
//        pv.image = UIImage(named: "car2019")
        pv.backgroundColor = .orange
        pv.contentMode = .scaleAspectFill
        pv.clipsToBounds = true
        return pv
    }()
    
    let priceLabel: UILabel = {
        let pl = UILabel()
        pl.text = "$150"
        pl.textAlignment = .center
        pl.textColor = .white
        pl.font = UIFont.boldSystemFont(ofSize: 14)
        return pl
    }()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.font = UIFont.boldSystemFont(ofSize: 18)
//        tl.text = "Porsche 2019"
        return tl
    }()
    
}
