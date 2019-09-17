//
//  MoreItemDetails.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/11/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class MoreItemDetailsCell: BaseListController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let itemDetailsDict: [String] = ["Category", "Condition", "Brand"]
    let titleDetails: [String] = ["Entertainment", "New", "App Creator"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemDetailsDict.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.view.backgroundColor = UITableView().separatorColor
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(navigationController?.pushViewController(HomeViewController(), animated: true)))
//        tapRecognizer.numberOfTapsRequired = 1
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemDetailCategoryCell
//        cell.addGestureRecognizer(tapRecognizer)
        
        cell.categoryTitle.text = itemDetailsDict[indexPath.item]
        cell.titleLabel.text = titleDetails[indexPath.item]
        
//        if indexPath.item > 0 {
//            let view = UIView()
//            view.backgroundColor = UITableView().separatorColor
//
//            cell.addSubview(view)
//            view.anchor(top: cell.topAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let titleLabel = UILabel(text: "Item Details", font: UIFont.boldSystemFont(ofSize: 22))
    let descriptionLabel = UILabel(text: "Description", font: UIFont.systemFont(ofSize: 17), numberOfLines: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(ItemDetailCategoryCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
}

class MoreItemDetail: UICollectionViewCell {
    let titleLabel = UILabel(text: "Item Details", font: UIFont.boldSystemFont(ofSize: 22))
    let descriptionLabel = UILabel(text: "Description", font: UIFont.systemFont(ofSize: 17), numberOfLines: 0)
    
    let itemDetailsCollection = MoreItemDetailsCell()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutViews()
        let view = UIView()
        view.backgroundColor = UITableView().separatorColor
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0.5)
    }
    
    func layoutViews() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(itemDetailsCollection.view)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 25)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)

        itemDetailsCollection.view.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 14, paddingRight: 0, width: 0, height: 120)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
