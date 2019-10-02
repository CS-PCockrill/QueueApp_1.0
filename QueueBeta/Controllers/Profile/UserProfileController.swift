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
        collectionView.register(UserReviewsCell.self, forCellWithReuseIdentifier: "cellId")
        
        self.navigationController?.navigationBar.tintColor = .black
        setupSettingsButton()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        //        header.usernameLabel.text = "Queue Technologies"
//        header.user = user
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userSettingsId, for: indexPath) as! UserStoreCell
            return cell
        } else if indexPath.item == 1 {
            let view = UIView()
            view.backgroundColor = UITableView().separatorColor
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! UserReviewsCell
            
            cell.addSubview(view)
            view.anchor(top: cell.topAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0.5)
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 224)
        } else if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: 195)
        }
        fatalError()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 280)
    }
    
    @objc func setupSettingsButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(handleLogout))
        
    }
    
    @objc func handleLogout() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
//                try Auth.auth().signOut()
                
                //what happens? we need to present some kind of login controller
                let loginController = GetStartedController()
                
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .overFullScreen
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
            
            
        }))
        alertController.addAction(UIAlertAction(title: "Edit Profile", style: .default, handler: { (_) in
            do {
                let editProfileController = EditProfileController(collectionViewLayout: UICollectionViewFlowLayout())
                let navController = UINavigationController(rootViewController: editProfileController)
                self.present(navController, animated: true, completion: nil)
            } catch let editProfErr {
                print("Failed to open edit profile:", editProfErr)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
//        let loginController = GetStartedController()
//        let navController = UINavigationController(rootViewController: loginController)
//        present(navController, animated: true, completion: nil)
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
    
    let usernameLabel: UILabel = {
        let ul = UILabel()
        ul.textAlignment = .center
        ul.text = "Patrick Cockrill"
        ul.font = UIFont.boldSystemFont(ofSize: 22)
        ul.textColor = .black
        return ul
    }()
    
    let dividerLineView: UIView = {
        let dlv = UIView()
        dlv.backgroundColor = UIColor.lightGray
        return dlv
    }()
    
    let userRatingsView: UserRatingView = {
        let view = UserRatingView()
        
        return view
    }()
    
    let userVerificationView: UserVerificationLevelView = {
        let view = UserVerificationLevelView()
        
        return view
    }()
    
    func setupProfileHeader() {
        addSubview(userProfileImage)
//        addSubview(userRatingsView)
//        addSubview(userVerificationView)
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
        
        addSubview(usernameLabel)
        
        usernameLabel.anchor(top: userProfileImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: 160, height: usernameLabel.intrinsicContentSize.height)
        usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [userRatingsView, userVerificationView], customSpacing: 8)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        addSubview(stackView)
        stackView.anchor(top: usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 108, height: 50)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
//        userRatingsView.anchor(top: usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
//        userRatingsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0.5)
        
    }
}
