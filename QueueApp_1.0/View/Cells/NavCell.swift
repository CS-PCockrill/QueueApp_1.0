//
//  NavCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/13/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class NavCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    var itemCategory: ItemCategory? {
        didSet {
            if let categoryName = itemCategory?.name {
                self.categoryTitle.text = categoryName
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    let categoryTitle: UILabel = {
        let ct = UILabel()
        ct.text = "Custom"
        ct.font = UIFont.boldSystemFont(ofSize: 14)
        ct.backgroundColor = UIColor.rgb(red: 236, green: 236, blue: 239)
        ct.layer.masksToBounds = true
        ct.layer.cornerRadius = 15
        ct.textAlignment = .center
//        ct.addTarget(self, action: #selector(handleCategory), for: .touchUpInside)
        // Gesture recognizer implementation...
        return ct
    }()
    
    func setupViews() {
        addSubview(categoryTitle)
//        addSubview(dividerView)
        categoryTitle.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
//        dividerView.anchor(top: categoryTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UILabel {
    public static func cellSize(label: UILabel) -> CGFloat {
        return label.intrinsicContentSize.width 
    }
    
}

