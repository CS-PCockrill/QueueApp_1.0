//
//  OfferPriceHeader.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class OfferPriceHeader: UICollectionReusableView {
    var app: Result?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.rgb(red: 31, green: 87, blue: 245).cgColor, UIColor.rgb(red: 1, green: 145, blue: 245).cgColor]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
//        backgroundColor = .rgb(red: 31, green: 87, blue: 245)
        setupViews()
    }
    
    let dollarSign = UILabel(text: "$", font: .boldSystemFont(ofSize: 30))
    
    let offerPrice: UITextField = {
        let offer = UITextField()
        offer.text = ""
        offer.textColor = .white
        offer.textAlignment = .center
        offer.font = UIFont.boldSystemFont(ofSize: 36)
        return offer
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    fileprivate func setupViews() {
        addSubview(dividerView)
        addSubview(offerPrice)
        addSubview(dollarSign)
        
        offerPrice.anchor(top: topAnchor, left: leftAnchor, bottom: dividerView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dividerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 40, paddingRight: 20, width: 0, height: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
