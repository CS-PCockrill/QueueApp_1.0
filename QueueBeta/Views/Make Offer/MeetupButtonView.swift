//
//  MeetupButtonView.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/20/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class MeetupButtonView: UIView {
    let containerView = UIView()
    let cornerRadius: CGFloat = 15.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutView()
    }
    
    let meetupLabel = UILabel(text: "Meetup", font: .boldSystemFont(ofSize: 20))
    
    let meetupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "profile_selected"), for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutView() {
        
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
        containerView.layer.borderColor = UIColor.rgb(red: 31, green: 87, blue: 245).cgColor
        containerView.layer.borderWidth = 0.5
        
        
        addSubview(containerView)
        containerView.addSubview(meetupButton)
        
        addSubview(meetupLabel)
        
        //
        // add additional views to the containerView here
//        addSubview(meetupButton)
//        meetupButton.fillSuperview()
        //
        
        // add constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // pin the containerView to the edges to the view
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        meetupButton.fillSuperview()
        meetupLabel.textAlignment = .center
        meetupLabel.anchor(top: containerView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: meetupLabel.intrinsicContentSize.height)
    }
}
