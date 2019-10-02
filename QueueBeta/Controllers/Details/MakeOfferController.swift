//
//  MakeOfferController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class MakeOfferController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let offerPriceId = "headerId"
    let itemDetailsID = "itemDetailsID"
    let deliveryDetailsID = "deliveryDetailsID"
    
    var app: Result?
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .rgb(red: 31, green: 87, blue: 245)
        self.title = "Make an Offer"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        collectionView.register(OfferPriceHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: offerPriceId)
        collectionView.register(OfferItemDetailsCell.self, forCellWithReuseIdentifier: itemDetailsID)
        collectionView.register(DeliveryInformationCell.self, forCellWithReuseIdentifier: deliveryDetailsID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: offerPriceId, for: indexPath) as! OfferPriceHeader
        header.offerPrice.text = app?.formattedPrice
        
        if header.offerPrice.text == nil {
            header.offerPrice.placeholder = app?.formattedPrice
            header.reloadInputViews()
        }
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemDetailsID, for: indexPath) as! OfferItemDetailsCell
            cell.itemImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            cell.itemTitleLabel.text = app?.trackName
            
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: deliveryDetailsID, for: indexPath) as! DeliveryInformationCell
            
            return cell
        }
        fatalError()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 150)
        } else if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: 240)
        }
        fatalError()
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
