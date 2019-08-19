//
//  ItemDescriptionCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class ItemDetailsCell: UICollectionViewCell {
    
    let nameLabel = UILabel(text: "Antique Vous", font: .boldSystemFont(ofSize: 28), numberOfLines: 1)
    let priceLabel = UILabel(text: "$99.00", font: .systemFont(ofSize: 20))
    let conditionLabel = UILabel(text: "Condition", font: .boldSystemFont(ofSize: 17))
    let descriptionLabel = UILabel(text: "Description", font: .systemFont(ofSize: 17), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        conditionLabel.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        conditionLabel.constrainHeight(constant: 32)
        conditionLabel.layer.cornerRadius = 32 / 2
        conditionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        let priceStack = UIStackView(arrangedSubviews: [priceLabel, conditionLabel])
        priceStack.axis = .vertical
        
        let namePriceStack = VerticalStackView(arrangedSubviews: [nameLabel, priceLabel, descriptionLabel], spacing: 10)
        namePriceStack.distribution = .equalCentering
        addSubview(namePriceStack)
    
        namePriceStack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        
//        nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: priceLabel.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 24)
//        priceLabel.anchor(top: nameLabel.topAnchor, left: nameLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 24)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIStackView {
    convenience init (arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
