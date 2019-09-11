//
//  CompactCategoryCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/4/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

// Load places in a promotional way... like sales or valentines day (Chocolates/Flowers, etc...)
// Area with hot picks, most clicked categories on this section?

//class CompactCategoryCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    let categoryId = "categoryId"
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        backgroundColor = .blue
//        setupCollectionView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = frame.width / 3.25 - 15
//        let height = frame.height
//        return CGSize(width: width, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as! CategoryItemCell
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 7.5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(123)
//    }
//
//    let itemsCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.white
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.showsHorizontalScrollIndicator = false
//        return collectionView
//    }()
//
//    private func setupCollectionView() {
//        addSubview(itemsCollectionView)
//        itemsCollectionView.dataSource = self
//        itemsCollectionView.delegate = self
//        itemsCollectionView.register(CategoryItemCell.self, forCellWithReuseIdentifier: categoryId)
//
//        itemsCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//
//    }
//}

class CategoryItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func createGradientLayer() {
//        gradientLayer = CAGradientLayer()
//
//        gradientLayer.frame = self.view.bounds
//
//        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
//
//        self.view.layer.addSublayer(gradientLayer)
//    }
    
    let imageView: UIView = {
        let iv = UIView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
//        iv.image = UIImage(named: "dirac")
//        iv.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
//        iv.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 244)
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ribbon")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var gradientLayer: CAGradientLayer!
    
    func setupViews() {
        addSubview(imageView)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
        imageView.addSubview(iconImage)
        iconImage.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        iconImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
//        imageView.addSubview(itemLabel)
//        itemLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 18)
    }
}

extension UIView {
    func withGradienBackground(color1: UIColor, color2: UIColor, color3: UIColor, color4: UIColor) {
        let layerGradient = CAGradientLayer()
        
        layerGradient.colors = [color1.cgColor, color2.cgColor, color3.cgColor, color4.cgColor]
        layerGradient.frame = bounds
        layerGradient.startPoint = CGPoint(x: 1.5, y: 1.5)
        layerGradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        layerGradient.locations = [0.0, 0.3, 0.4, 1.0]
        
        layer.insertSublayer(layerGradient, at: 0)
    }
}
