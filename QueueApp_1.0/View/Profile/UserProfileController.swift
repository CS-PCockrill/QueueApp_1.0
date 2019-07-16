//
//  UserProfileController.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/17/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
//        navigationController?.isNavigationBarHidden = false
        collectionView.backgroundColor = .white
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        setupLogOutButton()
        fetchUser()
    }
    
    var user: User?
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.user = User(uid: uid, dictionary: dictionary)
            
            self.collectionView.reloadData()
            
        }) { (error) in
            print("Failed to fetch current user:", error)
        }
        
        
    }
    
    private func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
    }
    @objc func handleLogout() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                //what happens? we need to present some kind of login controller
                let loginController = SignInController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
//        header.usernameLabel.text = "Queue Technologies"
        header.user = user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }

}

class UserProfileHeader: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Header user delegate??
    var user: User? {
        didSet {
            if let username = user?.username {
                usernameLabel.text = username
            }
            setupProfileImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileHeader()
    }
    
    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImage else { return }
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Failed to fetch profile image:", err)
                return
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.userProfileImage.image = image
            }
            
            }.resume()
        
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

