//
//  SuggestedRadiusCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SuggestedRadiusCell: UICollectionViewCell {
    let suggestedLabel = UILabel(text: "Suggested Radius", font: UIFont.boldSystemFont(ofSize: 20))
    let suggestedDescription = UILabel(text: "Show me listings from this general area", font: UIFont.systemFont(ofSize: 17), numberOfLines: 2)
    
    let verticalDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        
        return divider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let verticalStack = VerticalStackView(arrangedSubviews: [suggestedLabel, suggestedDescription], spacing: 0)
        addSubview(verticalStack)
        verticalStack.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        addSubview(verticalDivider)
        verticalDivider.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0.5)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
