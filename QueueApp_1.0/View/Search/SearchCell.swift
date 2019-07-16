//
//  SearchCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
//        let sectionLabel: UILabel = {
//            let sl = UILabel()
//            sl.text = "Recent Searches"
//            sl.font = UIFont.boldSystemFont(ofSize: 17)
//            return sl
//        }()
//        
        let searchLabel: UILabel = {
            let sl = UILabel()
            sl.text = "Example items"
            sl.backgroundColor = .white
            sl.font = UIFont.systemFont(ofSize: 17)
            return sl
        }()
        
        let searchIcon: UIImageView = {
            let si = UIImageView()
            si.image = UIImage(named: "home_unselected")
            return si
        }()
        
        addSubview(searchLabel)
        addSubview(searchIcon)
//        addSubview(sectionLabel)
        
        searchIcon.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 33, height: 33)
        searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        searchLabel.anchor(top: topAnchor, left: searchIcon.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(separatorView)
        separatorView.anchor(top: nil, left: searchLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
    }
}
