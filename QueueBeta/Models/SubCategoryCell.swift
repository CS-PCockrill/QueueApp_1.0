//
//  SubCategoryCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SubCategoryCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    let cellId = "cellId"
    
    //    let categories = ["Home": ["Tools", "Furniture", "Appliances", "Household"], "Entertainment": ["Bags & Luggage", "Men's Clothing & Shoes", "Women's Clothing & Shoes"], "Electronics": ["Mobile Phones", "Electronics & Computers"], "Hobbies": ["Sports & Outdoors", "Musical Instruments", "Auto Parts", "Bicycles"]]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SubCell
        
        cell.categoryLabel.text = "Sub Category"
        cell.backgroundColor = .gray
        
        //        cell.categoryLabel.text = subCategories[indexPath.section][indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selecting sub category")
        //        guard let key = nameLabel.text else { return }
        //        let item = categories.categories.values
        //        print(item)
        // Set item text to the categoryTitle text...
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - (iconImageView.frame.width + 20), height: 25)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(SubCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupPopupSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.isScrollEnabled = false
        
        return cv
    }()
    
    let nameLabel: UILabel = {
        let nl = UILabel()
        nl.text = "Category"
        nl.font = UIFont.boldSystemFont(ofSize: 20)
        return nl
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        //        iv.image = UIImage.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .darkGray
        iv.backgroundColor = .orange
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    fileprivate func setupPopupSettings() {
        addSubview(nameLabel)
        addSubview(iconImageView)
        addSubview(collectionView)
        
//        iconImageView.anchor(top: topAnchor, left: leftAnchor, bottom: collectionView.topAnchor, right: nameLabel.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 40, height: 40)
        nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 40)
        //        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        collectionView.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
