//
//  DeliveryInformationCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/20/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class DeliveryInformationCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        let view = UIView()
        view.backgroundColor = UITableView().separatorColor
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0.5)
        
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let meetupButton: MeetupButtonView = {
        let button = MeetupButtonView()
        return button
    }()
    
    let deliveryInfoLabel = UILabel(text: "Delivery Information", font: .boldSystemFont(ofSize: 22))
    
    fileprivate func layoutViews() {
        addSubview(deliveryInfoLabel)
        addSubview(meetupButton)
        
        deliveryInfoLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: deliveryInfoLabel.intrinsicContentSize.height)
        meetupButton.anchor(top: deliveryInfoLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 16, paddingLeft: 36, paddingBottom: 8, paddingRight: 50, width: (frame.width / 2) - 80, height: 0)
    }
}
