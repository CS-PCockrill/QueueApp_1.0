//
//  AddressLauncher.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class AddressLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    let currentId = "currentId"
    let savedAddressId = "savedId"
    let blackView = UIView()
    
    override init() {
        super.init()
        
        addressesCollectionView.delegate = self
        addressesCollectionView.dataSource = self
        addressesCollectionView.register(CurrentLocationCell.self, forCellWithReuseIdentifier: currentId)
        addressesCollectionView.register(SavedAddressCell.self, forCellWithReuseIdentifier: savedAddressId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = addressesCollectionView.dequeueReusableCell(withReuseIdentifier: currentId, for: indexPath) as! CurrentLocationCell
            
            return cell
        } else {
            let cell = addressesCollectionView.dequeueReusableCell(withReuseIdentifier: savedAddressId, for: indexPath) as! SavedAddressCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let window = UIApplication.shared.keyWindow {
            return CGSize(width: window.frame.width, height: 75)
        }
        return CGSize(width: 300, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let addressesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        cv.layer.cornerRadius = 15
        cv.layer.masksToBounds = true
        cv.isScrollEnabled = false
        return cv
    }()
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.addressesCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.addressesCollectionView.frame.width, height: self.addressesCollectionView.frame.height)
            }
        }
    }
    
    @objc func showAddresses() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            window.addSubview(blackView)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(addressesCollectionView)
            
            var height: CGFloat = 100
            height += 200
            let y = window.frame.height - height
            addressesCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.addressesCollectionView.frame = CGRect(x: 0, y: y, width: self.addressesCollectionView.frame.width, height: self.addressesCollectionView.frame.height)
            }, completion: nil)
            
        }
    }
}
