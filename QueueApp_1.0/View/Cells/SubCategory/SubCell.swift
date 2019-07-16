//
//  SubCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/9/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SubCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupCategoryLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Sub-Category"
        return label
    }()
    
    private func setupCategoryLabel() {
        addSubview(categoryLabel)
        categoryLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}
