//
//  UserReviewsCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/24/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class UserReviewsCell: UICollectionViewCell {
    let userReviewsCollection = UserReviewsCollection()
    let reviewsLabel = UILabel(text: "Reviews", font: UIFont.boldSystemFont(ofSize: 24))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reviewsLabel)
        addSubview(userReviewsCollection.view)
        reviewsLabel.textColor = .black
        
        reviewsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: reviewsLabel.intrinsicContentSize.height)
        userReviewsCollection.view.anchor(top: reviewsLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SingleReviewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UITableView().separatorColor
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UserReviewsCollection: BaseListController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.view.backgroundColor = UITableView().separatorColor
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SingleReviewCell
//        cell.imageView.image = UIImage(named: "patrick")
        //        cell.categoryTitle.text = itemDetailsDict[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width * 0.66), height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(SingleReviewCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}
