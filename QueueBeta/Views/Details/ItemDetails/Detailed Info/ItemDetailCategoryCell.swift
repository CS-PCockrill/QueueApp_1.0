//
//  ItemDetailCategoryCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/11/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class ItemDetailCategoryCell: UICollectionViewCell {
    let categoryTitle = UILabel(text: "Category", font: .boldSystemFont(ofSize: 17))
    let titleLabel = UILabel(text: "title", font: .systemFont(ofSize: 17))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        isUserInteractionEnabled = true
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func handleGesture() {
//        print("TEST")
//        self.window?.rootViewController?.present(UIViewController(), animated: true, completion: nil)
//    }
    
    fileprivate func layoutViews() {
        addSubview(categoryTitle)
        addSubview(titleLabel)

        categoryTitle.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 4, paddingRight: 0, width: frame.width * 0.60, height: 20)
        titleLabel.anchor(top: nil, left: categoryTitle.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        categoryTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
