//
//  SellerInformationCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/27/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SellerInformationCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SellerPayoutMethodCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Seller Payout Method")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 40)
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
//        cv.layer.cornerRadius = 15
        cv.layer.masksToBounds = true
        cv.isScrollEnabled = true
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView()
        view.backgroundColor = UITableView().separatorColor
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0.5)
        
        backgroundColor = .white
        collectionView.register(SellerPayoutMethodCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    let titleLabel = UILabel(text: "Seller Information", font: .boldSystemFont(ofSize: 22))
    let userFullName = UILabel(text: "Patrick Cockrill", font: .boldSystemFont(ofSize: 20))
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
        addSubview(userFullName)
        addSubview(collectionView)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 25)
        sellerImageView.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 60, height: 60)
        userFullName.anchor(top: titleLabel.bottomAnchor, left: sellerImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        userFullName.centerYAnchor.constraint(equalTo: sellerImageView.centerYAnchor).isActive = true
        sellerImageView.layer.cornerRadius = 30
        
        collectionView.anchor(top: sellerImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        sellerMapView.anchor(top: sellerImageView.bottomAnchor, left: leftAnchor, bottom: cityLabel.topAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 8, paddingRight: 16, width: 0, height: 80)
//        cityLabel.anchor(top: sellerMapView.bottomAnchor, left: sellerMapView.leftAnchor, bottom: approximateLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
//        approximateLabel.anchor(top: cityLabel.bottomAnchor, left: sellerMapView.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 0, height: 18)
        
        
    }
}

