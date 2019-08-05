//
//  SavedAddressCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SavedAddressCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame : frame)
        
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let clockIcon: UIImageView = {
        let image = UIImage(named: "clock_icon")?.withRenderingMode(.alwaysOriginal)
        let icon = UIImageView(image: image)
        
        return icon
    }()
    
    let streetLabel: UILabel = {
        let label = UILabel()
        label.text = "9918 Fairfax Square"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Fairfax, VA"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Meet at vehicle, 9918, Fairfax Square"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    private func setupViews() {
        addSubview(clockIcon)
        addSubview(streetLabel)
        addSubview(cityLabel)
        addSubview(deliveryLabel)
        clockIcon.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        clockIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        streetLabel.anchor(top: topAnchor, left: clockIcon.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 17)
        cityLabel.anchor(top: streetLabel.bottomAnchor, left: clockIcon.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        deliveryLabel.anchor(top: cityLabel.bottomAnchor, left: clockIcon.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        
        addSubview(dividerLineView)
        dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0.5)
    }
}
