//
//  SignUpController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/14/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import Photos

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        
        view.backgroundColor = .white
        setupViews()
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    let plusPhotoButton: UIButton = {
        let pb = UIButton(type: .system)
        pb.setImage(UIImage(named: "plus_photo"), for: .normal)
        pb.contentMode = .scaleAspectFill
        pb.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return pb
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
    
    let usernameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Username"
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
    
    let signUpButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setTitle("Sign Up", for: .normal)
        // Placeholder color
        sb.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        sb.layer.cornerRadius = 5
        sb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        //        sb.setTitleColor(.white, for: .normal)
        
        sb.layer.cornerRadius = 10
        sb.layer.masksToBounds = true
        sb.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        sb.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        sb.isEnabled = false
        return sb
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 31, green: 87, blue: 245)
            ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAlreadyHaveAccount() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSelectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 1
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleInputChange() {
        let isFormValid = emailTextField.text?.isEmpty == false && usernameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.setTitleColor(.white, for: .normal)
        } else {
            signUpButton.isEnabled = false
            signUpButton.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        }
    }
    
    @objc func handleSignUp() {
//        let layout = UICollectionViewFlowLayout()
//        let homeViewController = HomeViewController(collectionViewLayout: layout)
//        let navController = UINavigationController(rootViewController: MainTabBarController())
//        present(navController, animated: true, completion: nil)
        
        guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
        //
        mainTabBarController.setupNavIcons()
        //
        self.dismiss(animated: true, completion: nil)
    }
    
    //    @objc func handleSignUp() {
    //        guard let email = emailTextField.text, email.count > 0 else { return }
    //        guard let username = usernameTextField.text, username.count > 0 else { return }
    //        guard let password = passwordTextField.text, password.count > 0 else { return }
    //        guard let image = self.plusPhotoButton.imageView?.image else { return }
    //
    //        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
    //            if let err = error {
    //                print("Failed to Create user:", err)
    //                return
    //            }
    //            print("Successfully created user", user?.user.uid ?? "")
    //
    //            // Image upload data
    //            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
    //            let filename = NSUUID().uuidString
    //
    //            // Reference out to Firebase Storage, creating a child 'profile_image'
    //            let storageRef = Storage.storage().reference().child("profile_Image").child(filename)
    //            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
    //                if let err = error {
    //                    print("Failed to upload into Storage:", err)
    //                    return
    //                }
    //                storageRef.downloadURL(completion: { (downloadURL, err) in
    //                    guard let profileImageUrl = downloadURL?.absoluteString else { return }
    //
    //                    print("Successfully uploaded profile image:", profileImageUrl)
    //
    //                    // Upwrap users identification number
    //                    guard let uid = user?.user.uid else { return }
    //
    //                    // Save nested tree values (username, email, profileImage)
    //                    let dictionaryValues = ["username": username, "email": email, "profileImageUrl": profileImageUrl]
    //                    // Key value pair of uid and values inside...
    //                    let values = [uid: dictionaryValues]
    //
    //                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
    //                        if let err = err {
    //                            print("Failed to save user info into db:", err)
    //                            return
    //                        }
    //
    //                        print("Successfully saved user info to db")
    //
    //                        guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
    //
    //                        mainTabBarController.setupNavIcons()
    //
    //                        self.dismiss(animated: true, completion: nil)
    //
    //                    })
    //                })
    //            })
    //        }
    //    }
    
    private func setupViews() {
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 160, height: 160)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 0, width: 0, height: 50)
    }
}
