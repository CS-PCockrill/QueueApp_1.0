//
//  CategoryCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/13/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import Firebase

let LONG_WIDTH = (UIScreen.main.bounds.width * 0.75)
let LONG_HEIGHT = (UIScreen.main.bounds.width / 2)

let SHORT_WIDTH = (UIScreen.main.bounds.width / 2) - 10
let SHORT_HEIGHT = (UIScreen.main.bounds.width / 2) - 10

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var featuredCategoriesController: HomeViewController?
    var featuredItems: ItemCategory?
    
    // Sets the categories name label...
    var itemCategory: ItemCategory? {
        didSet {
            if let name = itemCategory?.name {
                categoryLabel.text = name
            }
        }
    }
    
    private let cellId = "cellId"

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Number of items in each category... (on Home page)
        if let count = itemCategory?.items?.count {
            return count
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        // Cell item asserts the items indexPath
        cell.item = itemCategory?.items?[indexPath.item]
        return cell
    }
    
    func showCategoryDetails(category: Item) {
        let layout = UICollectionViewFlowLayout()
        let categoryDetailController = DetailCategoryController(collectionViewLayout: layout)
        categoryDetailController.category = category
        //        categoryDetailController.categoryNames = category
        //        present(categoryDetailController, animated: true, completion: nil)
//        navigationController?.pushViewController(categoryDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Show the detailed Item details on tap of individual cells (images)
        guard let category = itemCategory?.items?[indexPath.item] else { return }
        featuredCategoriesController?.showItemDetails(item: category)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: LONG_WIDTH, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7.5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
//        fetchAllPosts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom collectionView for the items in each category
    let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let categoryLabel: UILabel = {
        let cl = UILabel()
        cl.text = "Today's Picks"
        cl.font = UIFont.boldSystemFont(ofSize: 20)
//        cl.font = UIFont(name: "Helvetica", size: 20)
//        cl.font = UIFont.boldSystemFont(ofSize: 20)
        return cl
    }()

    let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
//        button.addTarget(self, action: #selector(moreSelected), for: .touchUpInside)
        return button
    }()
    
    let settingsLauncher = SettingsLauncher()
    
    // Launch mini-settings
    @objc func moreSelected() {
        settingsLauncher.showSettings()
    }
    
    private func setupViews() {
        addSubview(itemsCollectionView)
//        addSubview(categoryView)

        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        itemsCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(categoryLabel)
        addSubview(optionsButton)
        let optionsGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreSelected))
        optionsGesture.numberOfTapsRequired = 1
        
        categoryLabel.anchor(top: topAnchor, left: leftAnchor, bottom: itemsCollectionView.topAnchor, right: rightAnchor, paddingTop: 6, paddingLeft: 14, paddingBottom: 6, paddingRight: 0, width: 0, height: 0)
        
        optionsButton.anchor(top: topAnchor, left: nil, bottom: itemsCollectionView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 0)
        optionsButton.addGestureRecognizer(optionsGesture)
        
        itemsCollectionView.anchor(top: optionsButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}

class ItemCell: UICollectionViewCell {
    
    // create an instance of Item?
    // didSet images/text/etc..
    var item: Item? {
        didSet {
            if let imageName = item?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            
            if let category = item?.categoryTitle {
                if category == "Store" {
                    addSubview(storeView)
                    addSubview(businessName)

                    businessName.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 50)
                    businessName.centerXAnchor.constraint(equalTo: storeView.centerXAnchor).isActive = true
                    businessName.centerYAnchor.constraint(equalTo: storeView.centerYAnchor).isActive = true
                    storeView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 130, height: 30)
                }
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let businessName: UILabel = {
        let bn = UILabel()
        bn.font = UIFont.boldSystemFont(ofSize: 17)
        bn.textColor = UIColor.white
        bn.layer.masksToBounds = true
        bn.textAlignment = .center
        return bn
    }()
    
    let storeView: UIView = {
        let sv = UIView()
        sv.backgroundColor = .black
        sv.layer.opacity = 0.65
        sv.layer.masksToBounds = true
        sv.layer.cornerRadius = 7.5
        return sv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        iv.layer.cornerRadius = 7.5
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    func setupViews() {
        addSubview(imageView)
    
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    }
}
