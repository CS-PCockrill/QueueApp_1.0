//
//  SettingsCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/21/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            if let image = setting?.imageName {
                iconImageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        setupPopupSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let nl = UILabel()
        nl.text = "Settings"
        nl.font = UIFont.systemFont(ofSize: 16)
        return nl
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
//        iv.image = UIImage.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .darkGray
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    fileprivate func setupPopupSettings() {
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
