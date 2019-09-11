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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: offerPriceId, for: indexPath) as! OfferPriceHeader
        return header
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
