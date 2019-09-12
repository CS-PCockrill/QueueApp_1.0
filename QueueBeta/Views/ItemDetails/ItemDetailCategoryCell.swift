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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let view = UIView()
        view.backgroundColor = UITableView().separatorColor
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutViews() {
        addSubview(categoryTitle)
        categoryTitle.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 0, width: frame.width * 0.60, height: 20)
        categoryTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
