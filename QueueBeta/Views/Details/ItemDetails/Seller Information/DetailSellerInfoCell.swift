//
//  DetailSellerInfoCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/20/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class DetailSellerInfoCell: BaseListController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let itemDetailsDict: [String] = ["Payout Method", "City", "Rating"]
    let titleDetails: [String] = ["Cash", "Reston, VA", "4.92"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemDetailsDict.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TESTING TESTING")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.view.backgroundColor = UITableView().separatorColor
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemDetailCategoryCell
        
        cell.categoryTitle.text = itemDetailsDict[indexPath.item]
        cell.titleLabel.text = titleDetails[indexPath.item]
        
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
        collectionView.alwaysBounceVertical = false
        collectionView.register(ItemDetailCategoryCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
}
