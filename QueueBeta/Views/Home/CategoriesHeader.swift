//
//  CategoryHeader.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/14/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class CategoriesHeader: UICollectionReusableView {
    
    let itemCategoriesHorizontalController = ItemCategoriesHeaderController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        itemCategoriesHorizontalController.view.backgroundColor = .orange
        addSubview(itemCategoriesHorizontalController.view)
        itemCategoriesHorizontalController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
