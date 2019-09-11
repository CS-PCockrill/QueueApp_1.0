//
//  SellerInformationCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/27/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SellerInformationCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView()
        view.backgroundColor = UITableView().separatorColor
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0.5)
        
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel = UILabel(text: "Seller Information", font: .boldSystemFont(ofSize: 22))
    let sellerImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    let cityLabel = UILabel(text: "Reston, VA", font: .boldSystemFont(ofSize: 14))
    let approximateLabel = UILabel(text: "Location is approximate", font: .systemFont(ofSize: 14))
    
    private func setupViews() {
        let sellerMapView = UIView()
        sellerMapView.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        sellerMapView.clipsToBounds = true
        sellerMapView.layer.cornerRadius = 10
        
        addSubview(sellerMapView)
        addSubview(cityLabel)
        addSubview(approximateLabel)
        addSubview(titleLabel)
        addSubview(sellerImageView)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 25)
        sellerImageView.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 60, height: 0)
        sellerImageView.layer.cornerRadius = 30
//        sellerMapView.anchor(top: sellerImageView.bottomAnchor, left: leftAnchor, bottom: cityLabel.topAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 8, paddingRight: 16, width: 0, height: 80)
//        cityLabel.anchor(top: sellerMapView.bottomAnchor, left: sellerMapView.leftAnchor, bottom: approximateLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
//        approximateLabel.anchor(top: cityLabel.bottomAnchor, left: sellerMapView.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 0, height: 18)
        
        
    }
}

