//
//  ItemDescriptionCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/20/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class ItemDescriptionCell: UICollectionViewCell {
    
    let itemTitle: UILabel = {
        let dl = UILabel()
        dl.font = UIFont.boldSystemFont(ofSize: 34)
        return dl
    }()
    
    var item: Item? {
        didSet {
            if let itemName = item?.itemTitle {
                itemTitle.text = itemName
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .rgb(red: 236, green: 236, blue: 239)
        setupDescriptionCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDescriptionCell() {
//        let itemLabel: UILabel = {
//            let il = UILabel()
//            il.text = "Test Test"
//            il.font = UIFont.boldSystemFont(ofSize: 22)
//            return il
//        }()
        
        addSubview(itemTitle)
        itemTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 50)

    }
    
}
