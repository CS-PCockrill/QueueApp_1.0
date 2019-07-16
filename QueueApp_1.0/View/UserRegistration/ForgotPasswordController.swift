//
//  ForgotPasswordController.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/3/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordController: UIViewController {
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        navigationController?.isNavigationBarHidden = false
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.toolbar.isTranslucent = false
        navigationController?.toolbar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleBack))
        view.addSubview(iconView)
        iconView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        
        setupViews()
    }
    
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext() {
        print("Checking")
    }
    
    let iconView: UIView = {
        let view = UIView()
        let iconLabel = UILabel()
        iconLabel.text = "Trouble logging in?"
        iconLabel.font = UIFont.boldSystemFont(ofSize: 27)
        iconLabel.textColor = .white
        
        view.addSubview(iconLabel)
        iconLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 100)
        iconLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your username or email and we'll send you a code to get back into your account"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter email/username"
        text.font = UIFont.systemFont(ofSize: 17)
        text.borderStyle = .roundedRect
        text.backgroundColor = .white
        return text
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.isEnabled = false
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    let backToLogin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back to login", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 31, green: 87, blue: 245), for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    let usernameButton: UILabel = {
        let button = UILabel()
        button.text = "Username"
        button.textAlignment = .center
//        button.backgroundColor = .lightGray
        button.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    let phoneButton: UILabel = {
        let button = UILabel()
        button.text = "Phone"
        button.textAlignment = .center
        //        button.backgroundColor = .lightGray
        button.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    var textField = UITextField()
    
    @objc func handleUsername() {
        print("Username")
        emailTextField.placeholder = "Enter username"
        
    }
    @objc func handlePhone() {
        print("Phone")
        emailTextField.placeholder = "Enter phone number"
    }
    
    private func setupViews() {
        
        let gestureRecognizerLeft:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleUsername))
        usernameButton.addGestureRecognizer(gestureRecognizerLeft)
        usernameButton.isUserInteractionEnabled = true
        let gestureRecognizerRight:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePhone))
        phoneButton.addGestureRecognizer(gestureRecognizerRight)
        phoneButton.isUserInteractionEnabled = true
//        view.addSubview(emailTextField)
//        emailTextField.anchor(top: iconView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        let segmentedStackView = UIStackView(arrangedSubviews: [usernameButton, phoneButton])
        segmentedStackView.axis = .horizontal
        segmentedStackView.distribution = .fillEqually
        segmentedStackView.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [segmentedStackView, emailTextField, nextButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: iconView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 150)
//        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(backToLogin)
        backToLogin.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 25)
    }

}
