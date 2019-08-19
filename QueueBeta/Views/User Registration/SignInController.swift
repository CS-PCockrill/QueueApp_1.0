//
//  SignInController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
//import Firebase

class SignInController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginViews()
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
    }
    
    @objc func handleLogin() {
//        let navController = UINavigationController(rootViewController: MainTabBarController())
//        present(navController, animated: true, completion: nil)
        
        guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
        //
        mainTabBarController.setupNavIcons()
        //
        self.dismiss(animated: true, completion: nil)
    }
    
    //
    //    @objc func handleLogin() {
    //        guard let email = emailTextField.text else { return }
    //        guard let password = passwordTextField.text else { return }
    //
    //        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, err) in
    //
    //            if let err = err {
    //                print("Failed to sign in with email:", err)
    //                return
    //            }
    //
    //            print("Successfully logged back in with user:", user?.user.uid ?? "")
    //
    //            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
    //
    //            mainTabBarController.setupNavIcons()
    //
    //            self.dismiss(animated: true, completion: nil)
    //
    //        })
    //    }
    
    @objc func handleInputChange() {
        let isFormValid = emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.setTitleColor(.white, for: .normal)
        } else {
            loginButton.isEnabled = false
            loginButton.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        }
    }
    
    let logoContainerView: UIView = {
        let view = UIView()
        let image = UIImage(named: "QueueLogo-Snow")
        
        let logoImageView = UIImageView(image: image)
        logoImageView.contentMode = .scaleAspectFill
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 75)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //
        view.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 255)
        return view
    }()
    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Email"
        text.borderStyle = .roundedRect
        
        text.font = UIFont.systemFont(ofSize: 17)
        text.backgroundColor = UIColor(white: 1, alpha: 0.2)
        text.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        return text
    }()
    
    let passwordTextField: UITextField = {
        let text = UITextField()
        text.isSecureTextEntry = true
        text.placeholder = "Password"
        text.borderStyle = .roundedRect
        
        text.font = UIFont.systemFont(ofSize: 17)
        text.backgroundColor = UIColor(white: 1, alpha: 0.2)
        text.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        return text
    }()
    
    let loginButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setTitle("Sign In", for: .normal)
        // Placeholder color
        sb.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        sb.layer.cornerRadius = 5
        sb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        //        sb.setTitleColor(.white, for: .normal)
        sb.layer.cornerRadius = 10
        sb.layer.masksToBounds = true
        sb.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        sb.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        sb.isEnabled = false
        return sb
    }()
    
    private func setupLoginViews() {
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: self.logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 150)
    }
}
