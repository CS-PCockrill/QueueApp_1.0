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
        navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = .white
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleShowSignUp))
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
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
        view.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
//        let layer = CAGradientLayer()
//        layer.frame = view.bounds
//        layer.colors = [UIColor.rgb(red: 31, green: 87, blue: 245).cgColor, UIColor.rgb(red: 1, green: 145, blue: 244).cgColor]
//        view.layer.addSublayer(layer)
        return view
    }()
    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Email"
        text.borderStyle = .none
        text.layer.masksToBounds = true
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
//        sb.layer.cornerRadius = 5
        sb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        //        sb.setTitleColor(.white, for: .normal)
        sb.layer.cornerRadius = 10
        sb.layer.masksToBounds = true
        sb.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        sb.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        sb.isEnabled = false
        return sb
    }()
    
    let forgotPassword: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 31, green: 87, blue: 245), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.rgb(red: 31, green: 87, blue: 245), for: .normal)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 31, green: 87, blue: 245)
            ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleForgotPassword() {
        let forgotPasswordController = ForgotPasswordController()
        let navController = UINavigationController(rootViewController: forgotPasswordController)
//        forgotPasswordController.view.backgroundColor = .purple
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleShowSignUp() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    private func setupLoginViews() {
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPassword, backButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        emailTextField.useUnderline()
        passwordTextField.useUnderline()
//        passwordTextField.layer.addSublayer(bottomLine)
        
        view.addSubview(stackView)
        stackView.anchor(top: self.logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 250)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 0, width: 0, height: 50)
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

extension UITextField {
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(5.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 31.0 / 255.0, green: 87.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 1.0 / 255.0, green: 37.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
