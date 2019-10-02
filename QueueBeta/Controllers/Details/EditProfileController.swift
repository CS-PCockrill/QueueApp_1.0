//
//  EditProfileController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/14/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class EditProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let personalInformationID = "personalInformationID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        collectionView.backgroundColor = .white
        collectionView.register(PersonalInformationCell.self, forCellWithReuseIdentifier: personalInformationID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalInformationID, for: indexPath) as! PersonalInformationCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
}

class PersonalInformationCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
