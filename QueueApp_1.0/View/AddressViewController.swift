//
//  AddressViewController.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/15/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let savedId = "savedAddressId"
    let currentId = "currentAddressId"
    var savedAddresses = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Delivery Details"
        
        addressesCollectionView.register(SavedAddressCell.self, forCellWithReuseIdentifier: savedId)
        addressesCollectionView.register(CurrentLocationCell.self, forCellWithReuseIdentifier: currentId)
        view.backgroundColor = UIColor.rgb(red: 244, green: 246, blue: 248)
        setupViews()
    }
    
    let addressesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        cv.layer.masksToBounds = true
        cv.isScrollEnabled = false
        return cv
    }()
    
    let enterCurrentLocation: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter a new address"
        text.font = UIFont.systemFont(ofSize: 17)
        return text
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0) {
            let cell = addressesCollectionView.dequeueReusableCell(withReuseIdentifier: currentId, for: indexPath) as! CurrentLocationCell
            
            return cell
        } else {
            let cell = addressesCollectionView.dequeueReusableCell(withReuseIdentifier: savedId, for: indexPath) as! SavedAddressCell
            
            return cell
        }
    }
    
    private func setupViews() {
        addressesCollectionView.delegate = self
        addressesCollectionView.dataSource = self
        
        let newAddressView = UIView()
        newAddressView.backgroundColor = .white
        let newAddressIcon = UIImageView()
        newAddressIcon.image = UIImage(named: "search_unselected")?.withRenderingMode(.alwaysOriginal)
        
        view.addSubview(newAddressView)
        view.addSubview(addressesCollectionView)
        newAddressView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        newAddressView.addSubview(newAddressIcon)
        newAddressView.addSubview(enterCurrentLocation)
        newAddressIcon.anchor(top: newAddressView.topAnchor, left: newAddressView.leftAnchor, bottom: newAddressView.bottomAnchor, right: enterCurrentLocation.leftAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 10, width: 20, height: 0)
        enterCurrentLocation.anchor(top: newAddressView.topAnchor, left: newAddressIcon.rightAnchor, bottom: newAddressView.bottomAnchor, right: newAddressView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addressesCollectionView.anchor(top: newAddressView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)

    }
}

class Address: NSObject {
    let streetAddress: String
    let city: String
    let deliveryType: String
    
    init(streetAddress: String, city: String, deliveryType: String) {
        self.streetAddress = streetAddress
        self.city = city
        self.deliveryType = deliveryType
    }
}
