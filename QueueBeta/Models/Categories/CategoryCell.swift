//
//  CategoryCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Category Section", font: .boldSystemFont(ofSize: 24))
    
    let horizontalController = ItemsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView()
        view.backgroundColor = .lightGray
        
        backgroundColor = .white
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0.33)
        addSubview(titleLabel)
        titleLabel.noPaddingAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .blue
        horizontalController.view.noPaddingAnchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
