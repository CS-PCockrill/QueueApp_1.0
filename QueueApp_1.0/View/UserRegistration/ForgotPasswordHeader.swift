//
//  ForgotPasswordHeader.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/3/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class ForgotPasswordHeader: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter email/username"
        text.font = UIFont.systemFont(ofSize: 17)
        text.backgroundColor = .white
        return text
    }()
    
    private func setupViews() {
        addSubview(emailTextField)
        emailTextField.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    }
}
