//
//  CurrentLocationCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
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
    
    let iconImageView: UIImageView = {
        let imageSrc = UIImage(named: "clock_icon")?.withRenderingMode(.alwaysOriginal)
        let image = UIImageView(image: imageSrc)
        return image
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    private func setupViews() {
        addSubview(iconImageView)
        addSubview(dividerLineView)
        
        iconImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0.5)
    }
    
}
