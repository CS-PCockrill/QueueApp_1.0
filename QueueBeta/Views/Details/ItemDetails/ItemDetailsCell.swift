//
//  ItemDescriptionCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class ItemOverviewCell: UICollectionViewCell {
    
    let messageContainerView = UIView()
    let nestedView = UIView()
    
    let nameLabel = UILabel(text: "Antique Vous", font: .boldSystemFont(ofSize: 28), numberOfLines: 2)
    let priceLabel = UILabel(text: "$99.00", font: .systemFont(ofSize: 20))
    let conditionLabel = UILabel(text: "Condition", font: .boldSystemFont(ofSize: 17))
    let descriptionLabel = UILabel(text: "Description", font: .systemFont(ofSize: 17), numberOfLines: 0)
    
    let messageView: SendMessageView = {
        let view = SendMessageView()
        
        return view
    }()
    
    let listedCity: UILabel = {
        let city = UILabel()
        city.text = "Listed over a week ago..."
        city.font = UIFont.systemFont(ofSize: 14)
        return city
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let namePriceStack = VerticalStackView(arrangedSubviews: [nameLabel, priceLabel, listedCity], spacing: 8)
            
        addSubview(namePriceStack)
        addSubview(messageView)
        namePriceStack.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 125)
        messageView.anchor(top: namePriceStack.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 20, paddingBottom: 16, paddingRight: 20, width: 0, height: 0)
//        messageContainerView.anchor(top: namePriceStack.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 20, paddingBottom: 16, paddingRight: 20, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SendMessageView: UIView {
    let messageContainerView = UIView()
    let sendMessageSellerLabel = UILabel(text: "Send message to seller", font: UIFont.boldSystemFont(ofSize: 14))
    
    let messageTextField: UITextField = {
        let text = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        text.leftView = paddingView
        text.leftViewMode = .always
//        text.borderStyle = .none
        text.text = "Is this still available?"
        text.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        text.clipsToBounds = true
        text.layer.cornerRadius = 10
        return text
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutViews() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4.0
        
        messageContainerView.layer.masksToBounds = true
        messageContainerView.layer.cornerRadius = 8
        messageContainerView.backgroundColor = .white
        
        addSubview(messageContainerView)
        messageContainerView.fillSuperview()
        messageContainerView.addSubview(sendMessageSellerLabel)
        messageContainerView.addSubview(messageTextField)
        messageContainerView.addSubview(sendMessageButton)
        
        sendMessageSellerLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        messageTextField.anchor(top: sendMessageSellerLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 10, paddingBottom: 8, paddingRight: 10, width: frame.width * 0.75, height: 0)
//        sendMessageButton.anchor(top: messageTextField.topAnchor, left: messageTextField.rightAnchor, bottom: messageTextField.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
}

extension UIStackView {
    convenience init (arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
