//
//  UserProfileInfoViews.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 10/1/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class UserRatingView: UIView {
    let ratingContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.95"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate func setupViews() {
        ratingContainerView.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        ratingContainerView.clipsToBounds = true
        
        ratingContainerView.addSubview(userRatingLabel)
        userRatingLabel.fillSuperview()
//        userRatingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        userRatingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(ratingContainerView)
        ratingContainerView.layer.cornerRadius = 25
        ratingContainerView.translatesAutoresizingMaskIntoConstraints = false
        // pin the containerView to the edges to the view
        ratingContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ratingContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        ratingContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ratingContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
}

class UserVerificationLevelView: UIView {
    let verificationContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userVerificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Lvl 3"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate func setupViews() {
        verificationContainerView.backgroundColor = UIColor.systemPurple
        verificationContainerView.clipsToBounds = true
        
        verificationContainerView.addSubview(userVerificationLabel)
        userVerificationLabel.fillSuperview()
//        userRatingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        userRatingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(verificationContainerView)
        verificationContainerView.layer.cornerRadius = 25
        verificationContainerView.translatesAutoresizingMaskIntoConstraints = false
        // pin the containerView to the edges to the view
        verificationContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        verificationContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        verificationContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verificationContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
}
