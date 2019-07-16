//
//  CategoryHeaderView.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/20/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class CategoryHeaderView: UICollectionViewCell {

    
    private let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
