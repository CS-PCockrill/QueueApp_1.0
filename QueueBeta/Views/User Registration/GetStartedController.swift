//
//  GetStartedController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/27/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class GetStartedController: UIViewController {
    let loginContainerView = UIView()
    let signUpContainerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "QueueLogo-Snow")
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = image
        return view
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushSignIn), for: .touchUpInside)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func pushSignIn() {
        let view = SignInController()
        let navController = UINavigationController(rootViewController: view)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func pushSignUp() {
        let view = SignUpController()
        let navController = UINavigationController(rootViewController: view)
        present(navController, animated: true, completion: nil)
    }
    
    private func setupViews() {
        loginContainerView.layer.backgroundColor = UIColor.clear.cgColor
        loginContainerView.layer.shadowColor = UIColor.black.cgColor
        loginContainerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        loginContainerView.layer.shadowOpacity = 0.15
        loginContainerView.layer.shadowRadius = 10
        
        signUpContainerView.layer.backgroundColor = UIColor.clear.cgColor
        signUpContainerView.layer.shadowColor = UIColor.black.cgColor
        signUpContainerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        signUpContainerView.layer.shadowOpacity = 0.15
        signUpContainerView.layer.shadowRadius = 10

        //
        // add additional views to the containerView here
        //
        // add constraints
        loginContainerView.translatesAutoresizingMaskIntoConstraints = false
        signUpContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginContainerView)
        view.addSubview(signUpContainerView)
        // pin the containerView to the edges to the view
        loginContainerView.anchor(top: nil, left: nil, bottom: signUpContainerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: 300, height: 45)
        signUpContainerView.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 125, paddingRight: 0, width: 300, height: 45)
        signUpContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginContainerView.addSubview(signInButton)
        signUpContainerView.addSubview(signUpButton)
        signInButton.layer.cornerRadius = 22.5
        signInButton.layer.masksToBounds = true
        signInButton.fillSuperview()
        
        signUpButton.layer.cornerRadius = 22.5
        signUpButton.layer.masksToBounds = true
        signUpButton.fillSuperview()
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: view.frame.height * 0.33, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 175, height: 87.5)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor.rgb(red: 31, green: 87, blue: 245).cgColor
        let colorBottom = UIColor.rgb(red: 1, green: 145, blue: 244).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}


