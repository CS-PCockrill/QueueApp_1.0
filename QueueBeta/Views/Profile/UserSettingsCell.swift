//
//  UserSettingsCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/13/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class UserStoreCell: UICollectionViewCell {
    let userSettingsLabel = UILabel(text: "Store", font: .boldSystemFont(ofSize: 24))
    
    let settingsCollectionView = UserStoreCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .orange
        layoutViews()
    }
    
    private func layoutViews() {
        addSubview(userSettingsLabel)
        userSettingsLabel.textColor = .black
        userSettingsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        addSubview(settingsCollectionView.view)
        settingsCollectionView.view.anchor(top: userSettingsLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class UserStoreCollectionView: BaseListController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let itemDetailsDict: [String] = ["Account Information", "Condition", "Brand"]
//    let titleDetails: [String] = ["Entertainment", "New", "App Creator"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemDetailsDict.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.view.backgroundColor = UITableView().separatorColor
        //        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(navigationController?.pushViewController(HomeViewController(), animated: true)))
        //        tapRecognizer.numberOfTapsRequired = 1
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoreItemCell
        cell.imageView.image = UIImage(named: "patrick")
//        cell.categoryTitle.text = itemDetailsDict[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
//    let titleLabel = UILabel(text: "Item Details", font: UIFont.boldSystemFont(ofSize: 22))
//    let descriptionLabel = UILabel(text: "Description", font: UIFont.systemFont(ofSize: 17), numberOfLines: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(StoreItemCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
}

class StoreItemCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .black
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .purple
        return image
    }()
    
    private func layoutViews() {
        addSubview(imageView)
        imageView.fillSuperview()
    }
}


