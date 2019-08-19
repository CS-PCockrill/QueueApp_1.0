//
//  ApplyLocationFooter.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class ApplyLocationFooter: UICollectionReusableView {
    let setLocationController = SetLocationController()
    
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleApply), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitle("Apply", for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        return button
    }()
    
    let verticalDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        
        return divider
    }()
    
    
    @objc func handleApply() {
        // The current view heirachys rootView, dismiss it...
        self.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(applyButton)
        addSubview(verticalDivider)
        verticalDivider.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        applyButton.fillSuperview(padding: .init(top: 10, left: 10, bottom: 5, right: 10))
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
