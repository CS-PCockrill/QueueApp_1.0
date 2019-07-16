//
//  CurrentLocationCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/15/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class CurrentLocationCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    private func setupViews() {
        addSubview(dividerLineView)
        dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0.5)
    }
    
}
