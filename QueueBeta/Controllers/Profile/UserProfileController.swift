//
//  UserProfileController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
//import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let userSettingsId = "userSettingsId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        //        navigationController?.isNavigationBarHidden = false
        collectionView.backgroundColor = .white
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView.register(UserStoreCell.self, forCellWithReuseIdentifier: userSettingsId)
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(handleLogout))
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        //        header.usernameLabel.text = "Queue Technologies"
//        header.user = user
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userSettingsId, for: indexPath) as! UserStoreCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 244)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    @objc func handleLogout() {
        let loginController = GetStartedController()
        let navController = UINavigationController(rootViewController: loginController)
        present(navController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 280)
    }
    
}



class UserProfileHeader: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileHeader()
//        backgroundColor = .purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userProfileImage: UIImageView = {
        let ui = UIImageView()
        ui.clipsToBounds = true
        ui.contentMode = .scaleAspectFill
        ui.image = UIImage(named: "patrick")
        //        ui.addTarget(self, action: #selector(handleProfilePhoto), for: .touchUpInside)
        return ui
    }()
    
//    let logoutButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal), for: .normal)
////        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
//        return button
//    }()
    
    let usernameLabel: UILabel = {
        let ul = UILabel()
        ul.textAlignment = .center
        ul.text = "Patrick Cockrill"
        ul.font = UIFont.boldSystemFont(ofSize: 22)
        return ul
    }()
    
    let dividerLineView: UIView = {
        let dlv = UIView()
        dlv.backgroundColor = UIColor.lightGray
        return dlv
    }()
    
    let userRating: UILabel = {
        let ur = UILabel()
        ur.text = "4.95"
        ur.font = UIFont.systemFont(ofSize: 17)
        ur.textColor = UIColor.gray
        ur.textAlignment = .center
        return ur
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.addTarget(self, action: #selector(handleEditProfile), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.rgb(red: 31, green: 87, blue: 245), for: .normal)
        button.layer.borderColor = UIColor.rgb(red: 31, green: 87, blue: 245).cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    @objc func handleEditProfile() {
        print("TEST")
        let view = UICollectionViewFlowLayout()
        let controller = EditProfileController(collectionViewLayout: view)
        self.window?.rootViewController?.present(controller, animated: true, completion: nil)
    }
    
    @objc func handleProfilePhoto() {
        print("handling")
        //        let imagePickerController = UIImagePickerController()
        //        imagePickerController.delegate = self
        //        imagePickerController.allowsEditing = true
        //        present(imagePickerController, animated: true, completion: nil)
    }
    
    func setupProfileHeader() {
        addSubview(userProfileImage)
        let dividerLineView = UIView()
        dividerLineView.backgroundColor = .lightGray
        addSubview(dividerLineView)
//        addSubview(usernameLabel)
        
//        addSubview(dividerLineView)
//        addSubview(userRating)
//        addSubview(editProfileButton)
        
        userProfileImage.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        userProfileImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userProfileImage.layer.cornerRadius = 140 / 2
        
        let stackView = VerticalStackView(arrangedSubviews: [usernameLabel, userRating, editProfileButton], spacing: 8)
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        stackView.anchor(top: userProfileImage.bottomAnchor, left: nil, bottom: dividerLineView.topAnchor, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: 160, height: 0)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0.5)
        
//        usernameLabel.anchor(top: userProfileImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 30)
//
//        userRating.anchor(top: usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2.5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 20)
//
//        editProfileButton.anchor(top: userRating.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 80, height: 40)
//        editProfileButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
    }
}
