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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        //        navigationController?.isNavigationBarHidden = false
        collectionView.backgroundColor = .white
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(handleLogout))
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        //        header.usernameLabel.text = "Queue Technologies"
//        header.user = user
        return header
    }
    
    @objc func handleLogout() {
        let loginController = GetStartedController()
        let navController = UINavigationController(rootViewController: loginController)
        present(navController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
    
}

class UserProfileHeader: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userProfileImage: UIImageView = {
        let ui = UIImageView()
        ui.clipsToBounds = true
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
    
    @objc func handleProfilePhoto() {
        print("handling")
        //        let imagePickerController = UIImagePickerController()
        //        imagePickerController.delegate = self
        //        imagePickerController.allowsEditing = true
        //        present(imagePickerController, animated: true, completion: nil)
    }
    
    func setupProfileHeader() {
        addSubview(userProfileImage)
        addSubview(usernameLabel)
        addSubview(dividerLineView)
        addSubview(userRating)
        
        userProfileImage.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        userProfileImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userProfileImage.layer.cornerRadius = 140 / 2
        
        usernameLabel.anchor(top: userProfileImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 30)
        
        userRating.anchor(top: usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2.5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 20)
        
        dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: frame.width, height: 0.5)
        
    }
}
